Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F5AC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F7B2173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F7B2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnN7q-0000tZ-53
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 09:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43343)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnN7e-0000Mt-IX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnN7c-0006Pb-Uz
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:03:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnN7c-0006Nt-Cd
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:03:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so18628335wmg.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 06:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E5AKl2o7owi0w+xOpVqpMSzBgwOqyvpzMuSIi2VwvS8=;
 b=b0oILAJeBTNjzskFZP0go4wKxjkucGFl9OkXDJKwkHM9PCV3zEJ7HzSlSqd9FOiXKc
 Ni3gnJJode1lcD8DXFzDeUlaLU5B7pvQom9BX/PtBEUKxpPxhewL71AJfqhcH48IqVI+
 eLakkt7p8s5FGeGS9TG7T8xfLtp9CMAS/bDtEDZ/83pQ4PVJHFP/u0zRkyN046DIYG2L
 omySpHGPS0OQdAVM1oldRbtIEltnKlktd4zvWomaDOBND8TATeJYE0lSbP3HSDRiKTuu
 RJ/zgSZ0RAC0raG0LJjEP4ofQeuPJTLYRz1+gUNA11VXokm6YTCCO6KYwRvT+8frb8Vf
 qAZQ==
X-Gm-Message-State: APjAAAWL5aeNfQxiKsRQ6K4d+7p9UOyhmUsfqn/cTdzv3dRRi1FuFFib
 ZXIFA+JniCQ/laZz+4N/0DqyQw==
X-Google-Smtp-Source: APXvYqx6C8yxthDiVfL4AUUPlc3DCqAH8JbR9oPD7VEJBJXec3ajOgTUY2ktu2kri1eoP+AlIgnA9Q==
X-Received: by 2002:a1c:be19:: with SMTP id o25mr29266396wmf.54.1563282235208; 
 Tue, 16 Jul 2019 06:03:55 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id n9sm37109580wrp.54.2019.07.16.06.03.53
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 06:03:54 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190715174817.18981-1-philmd@redhat.com>
 <20190715174817.18981-2-philmd@redhat.com> <87ef2quu53.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <594aeb2a-cf54-16be-fdfa-05fb7a96842b@redhat.com>
Date: Tue, 16 Jul 2019 15:03:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87ef2quu53.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [NOTFORMERGE PATCH v2 1/9] tests/docker: Kludge to
 build the Fedora image
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Helge Deller <deller@gmx.de>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 12:54 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Rebuilding the Fedora image is failing:
>>
>>   $ make docker-image-fedora V=1
> 
> Broken build state? Just do:
> 
>   make docker-image-fedora V=1 NOCACHE=1

No, this doesn't help:

$ make docker-image-fedora V=1 NOCACHE=1
./tests/docker/docker.py build qemu:fedora
tests/docker/dockerfiles/fedora.docker  --no-cache --add-current-user
Sending build context to Docker daemon  4.096kB
Step 1/8 : FROM fedora:30
 ---> 9754ce14641d
Step 2/8 : ENV PACKAGES     bc     bison     bluez-libs-devel
brlapi-devel     bzip2     bzip2-devel     ccache     clang
cyrus-sasl-devel     device-mapper-multipath-devel     findutils
flex     gcc     gcc-c++     gettext     git     glib2-devel
glusterfs-api-devel     gnutls-devel     gtk3-devel     hostname
libaio-devel     libasan     libattr-devel     libblockdev-mpath-devel
   libcap-devel     libcap-ng-devel     libcurl-devel     libfdt-devel
   libiscsi-devel     libjpeg-devel     libpmem-devel     libpng-devel
   librbd-devel     libseccomp-devel     libssh-devel     libubsan
libusbx-devel     libxml2-devel     llvm     lzo-devel     make
mingw32-bzip2     mingw32-curl     mingw32-glib2     mingw32-gmp
mingw32-gnutls     mingw32-gtk3     mingw32-libjpeg-turbo
mingw32-libpng     mingw32-libtasn1     mingw32-nettle
mingw32-pixman     mingw32-pkg-config     mingw32-SDL2     mingw64-bzip2
    mingw64-curl     mingw64-glib2     mingw64-gmp     mingw64-gnutls
  mingw64-gtk3     mingw64-libjpeg-turbo     mingw64-libpng
mingw64-libtasn1     mingw64-nettle     mingw64-pixman
mingw64-pkg-config     mingw64-SDL2     ncurses-devel     nettle-devel
   nss-devel     numactl-devel     perl     perl-Test-Harness
pixman-devel     python3     python3-sphinx     PyYAML
rdma-core-devel     SDL2-devel     snappy-devel     sparse
spice-server-devel     systemd-devel     systemtap-sdt-devel     tar
 usbredir-devel     virglrenderer-devel     vte291-devel     which
xen-devel     zlib-devel
 ---> Running in dfeaaaa6bd31
Removing intermediate container dfeaaaa6bd31
 ---> 853735cf32a1
Step 3/8 : ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
 ---> Running in 64af2877181d
Removing intermediate container 64af2877181d
 ---> 2cb74a994b35
Step 4/8 : RUN dnf install -y $PACKAGES
 ---> Running in 106e7fcb2900
Fedora Modular 30 - x86_64                      2.1 MB/s | 2.7 MB
00:01
Fedora Modular 30 - x86_64 - Updates            1.6 MB/s | 2.3 MB
00:01
Fedora 30 - x86_64 - Updates                    6.3 MB/s |  17 MB
00:02
Failed to synchronize cache for repo 'updates'
Error: Failed to synchronize cache for repo 'updates'
The command '/bin/sh -c dnf install -y $PACKAGES' returned a non-zero
code: 1

>>   [...]
>>   Step 4/8 : RUN dnf install -y $PACKAGES
>>    ---> Running in cef9615efafb
>>   Fedora Modular 30 - x86_64                      2.0 MB/s | 2.7 MB     00:01
>>   Fedora Modular 30 - x86_64 - Updates            1.6 MB/s | 2.3 MB     00:01
>>   Fedora 30 - x86_64 - Updates                    6.1 MB/s |  17 MB     00:02
>>   Failed to synchronize cache for repo 'updates'
>>   Error: Failed to synchronize cache for repo 'updates'
>>   The command '/bin/sh -c dnf install -y $PACKAGES' returned a non-zero code: 1
>>   Traceback (most recent call last):
>>     File "./tests/docker/docker.py", line 615, in <module>
>>       sys.exit(main())
>>     File "./tests/docker/docker.py", line 611, in main
>>       return args.cmdobj.run(args, argv)
>>     File "./tests/docker/docker.py", line 413, in run
>>       extra_files_cksum=cksum)
>>     File "./tests/docker/docker.py", line 280, in build_image
>>       quiet=quiet)
>>     File "./tests/docker/docker.py", line 207, in _do_check
>>       return subprocess.check_call(self._command + cmd, **kwargs)
>>     File "/usr/lib64/python2.7/subprocess.py", line 190, in check_call
>>       raise CalledProcessError(retcode, cmd)
>>   subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu:fedora', '-f', '/tmp/docker_buildbKtWAa/tmpIctHw2.docker', '/tmp/docker_buildbKtWAa']' returned non-zero exit status 1
>>   make: *** [tests/docker/Makefile.include:53: docker-image-fedora] Error 1
>>
>> The fix found in one of the comment from this thread helped to have
>> it working again: https://bugzilla.redhat.com/show_bug.cgi?id=1706627
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> I have no idea what it does, it just works (TM).
>> ---
>>  tests/docker/dockerfiles/fedora.docker | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
>> index e6d39e14cb..f6be5e2dd7 100644
>> --- a/tests/docker/dockerfiles/fedora.docker
>> +++ b/tests/docker/dockerfiles/fedora.docker
>> @@ -94,6 +94,7 @@ ENV PACKAGES \
>>      zlib-devel
>>  ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
>>
>> -RUN dnf install -y $PACKAGES
>> +RUN echo zchunk=False >> /etc/dnf/dnf.conf
>> +RUN dnf clean metadata && dnf install -y $PACKAGES
>>  RUN rpm -q $PACKAGES | sort > /packages.txt
>>  ENV FEATURES mingw clang pyyaml asan
> 
> 
> --
> Alex Bennée
> 

