Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F2EC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9862086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9862086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw2H9-0001ii-W4
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60149)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw2Gd-00011Z-N8
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw2Gc-0007yd-D4
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:37:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw2Gc-0007wq-5z
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:37:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so7522303wrj.12
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 03:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=snUSDMaHT0dkWjqbmbJD7fV7IMAqYESNYdNhkRnOlmI=;
 b=KOELER3l81v10iJ7OnrhgaPoTyi91c71eu7zs7oWT5y2V0C8nDrfqDXVlGLEzE+6uV
 A5Ifxq4u6TPj8fVFIaDK7JQqX8Iv/WkKP08o2C4naVODnWul2/VxgcbHlII1ZY+dccdz
 nKKVRv9gTWP2ERHWanfqg+dBjri/dGPMFCzxCD6lIImVU7dRGpO03Gu0KjQm7jYff554
 oGT9zevGnuiLE2Zbzlrton/1cYS2oaT8wVXV6xMpgzffykhoWMFp9iFdvi6Zf07f2mi5
 R/ZJJq154bLJ1jgv5LtV1WCS42BwraTOHzvvKkKeyqAoeC125FKtUJCRMr9HF8zFIJbL
 RiIw==
X-Gm-Message-State: APjAAAWy0aaDuZdKDNQzqc2pjh78Aw6EJ1JR85mM9FkZ2U6qgCZIrP3k
 JAv0byiIXovEUyMH9w+X5HoctQ==
X-Google-Smtp-Source: APXvYqz26qQlDwbs+5d19hnISBoREzTK5kCuR2oeXYf7HYSfEEjVs3WLYxTaPkv+33M+7KlsS4FXdw==
X-Received: by 2002:adf:8bc2:: with SMTP id w2mr23188828wra.7.1565347021212;
 Fri, 09 Aug 2019 03:37:01 -0700 (PDT)
Received: from [192.168.50.36] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id f10sm85492098wrs.22.2019.08.09.03.37.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 03:37:00 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-21-armbru@redhat.com>
 <c76aaebc-d4bf-cb25-fe27-7a9c9ba644c9@redhat.com>
 <7f824b69-d506-e6ad-8fa9-3d3c232db02c@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0534a308-3868-6139-1ae0-bf03eeb9a145@redhat.com>
Date: Fri, 9 Aug 2019 12:36:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7f824b69-d506-e6ad-8fa9-3d3c232db02c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 20/29] Include qemu/main-loop.h less
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 12:29 PM, Philippe Mathieu-Daudé wrote:
> On 8/9/19 11:42 AM, Philippe Mathieu-Daudé wrote:
> [...]
>> netmap failing again :S
>>
>> $ make docker-image-debian-amd64 V=1 DEBUG=1
>> [...]
>>   CC      net/netmap.o
>> net/netmap.c: In function 'netmap_update_fd_handler':
>> net/netmap.c:109:5: error: implicit declaration of function
>> 'qemu_set_fd_handler' [-Werror=implicit-function-declaration]
>>      qemu_set_fd_handler(s->nmd->fd,
>>      ^~~~~~~~~~~~~~~~~~~
>> net/netmap.c:109:5: error: nested extern declaration of
>> 'qemu_set_fd_handler' [-Werror=nested-externs]
> 
> Since it might not be obvious to see how helpful/powerful is Docker, I
> gathered few notes (already posted once) about how I use it (often
> bisecting).
> 
> # Automatically create a base image (the image is then cached)
> $ make docker-image-debian-s390x-cross
> 
> # Create a out-of-tree build directory
> $ mkdir build/docker_s390x
> 
> # Run ./configure
> #
> # --rm  : Use a temp copy of the base image (do not modify it)
> # -v ...: Mount the current directory within the container
> # -w ...: Start the shell in the out-of-tree directory
> # -u ...: Use same UID as my user so I can remove the files after
> # $QEMU_CONFIGURE_OPTS contains the cross-compile options
> #
> $ docker run --rm \
>   -v $PWD:$PWD \
>   -w $PWD/build/docker_s390x \
>   -u $UID \
>   qemu:debian-s390x-cross \
>     \
>     sh -c "../../configure \$QEMU_CONFIGURE_OPTS"
> 
> I use 'sh -c' to escape $QEMU_CONFIGURE_OPTS, there might be a cleaner
> way to do this.
> 
> # Stupid step to speed up bisection
> # This will:
> # - clone submodules if necessary
> # - build slirp
> # - build fdt
> # - build capstone
> # - generated bunch of headers
> # - generated bunch of trace files
> $ docker run --rm \
>   -v $PWD:$PWD \
>   -w $PWD/build/docker_s390x \
>   -u $UID \
>   qemu:debian-s390x-cross \
>     \
>     make stubs/qtest.o
> 
> Now the directory is ready for building/bisecting.
> 
> I.e. build a single file:
> 
> $ docker run --rm \
>   -v $PWD:$PWD \
>   -w $PWD/build/docker_s390x \
>   -u $UID \
>   qemu:debian-s390x-cross \
>     \
>     make -C s390x-softmmu hw/intc/s390_flic_kvm.o
> 
> make: Entering directory 'build/docker_s390x/s390x-softmmu'
>   CC      hw/intc/s390_flic_kvm.o
> hw/intc/s390_flic_kvm.c: In function 'kvm_flic_save':
> hw/intc/s390_flic_kvm.c:395:9: error: implicit declaration of function
> 'qemu_put_be64' [-Werror=implicit-function-declaration]
>          qemu_put_be64(f, FLIC_FAILED);
>          ^~~~~~~~~~~~~
> hw/intc/s390_flic_kvm.c:395:9: error: nested extern declaration of
> 'qemu_put_be64' [-Werror=nested-externs]
> hw/intc/s390_flic_kvm.c:410:9: error: implicit declaration of function
> 'qemu_put_buffer' [-Werror=implicit-function-declaration]
>          qemu_put_buffer(f, (uint8_t *) buf,
>          ^~~~~~~~~~~~~~~
> hw/intc/s390_flic_kvm.c:410:9: error: nested extern declaration of
> 'qemu_put_buffer' [-Werror=nested-externs]
> hw/intc/s390_flic_kvm.c: In function 'kvm_flic_load':
> hw/intc/s390_flic_kvm.c:438:13: error: implicit declaration of function
> 'qemu_get_be64' [-Werror=implicit-function-declaration]
>      count = qemu_get_be64(f);
>              ^~~~~~~~~~~~~
> hw/intc/s390_flic_kvm.c:438:5: error: nested extern declaration of
> 'qemu_get_be64' [-Werror=nested-externs]
>      count = qemu_get_be64(f);
>      ^~~~~
> hw/intc/s390_flic_kvm.c:454:9: error: implicit declaration of function
> 'qemu_get_buffer' [-Werror=implicit-function-declaration]
>      if (qemu_get_buffer(f, (uint8_t *) buf, len) != len) {
>          ^~~~~~~~~~~~~~~
> hw/intc/s390_flic_kvm.c:454:5: error: nested extern declaration of
> 'qemu_get_buffer' [-Werror=nested-externs]
>      if (qemu_get_buffer(f, (uint8_t *) buf, len) != len) {
>      ^~
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/intc/s390_flic_kvm.o' failed
> make: *** [hw/intc/s390_flic_kvm.o] Error 1
> make: Leaving directory 'build/docker_s390x/s390x-softmmu'

Oops replied to incorrect thread haha =)

So adapted for amd64:


# Automatically create a base image (the image is then cached)
$ make docker-image-debian-amd64

# Create a out-of-tree build directory
$ mkdir build/docker_amd64

# Run ./configure
#
# --rm  : Use a temp copy of the base image (do not modify it)
# -v ...: Mount the current directory within the container
# -w ...: Start the shell in the out-of-tree directory
# -u ...: Use same UID as my user so I can remove the files after
# $QEMU_CONFIGURE_OPTS contains the cross-compile options
#
$ docker run --rm \
  -v $PWD:$PWD \
  -w $PWD/build/docker_amd64 \
  -u $UID \
  qemu:debian-amd64 \
    \
    sh -c "../../configure \$QEMU_CONFIGURE_OPTS"

I use 'sh -c' to escape $QEMU_CONFIGURE_OPTS, there might be a cleaner
way to do this.

# Stupid step to speed up bisection
# This will:
# - clone submodules if necessary
# - build slirp
# - build fdt
# - build capstone
# - generated bunch of headers
# - generated bunch of trace files
$ docker run --rm \
  -v $PWD:$PWD \
  -w $PWD/build/docker_amd64 \
  -u $UID \
  qemu:debian-amd64 \
    \
    make stubs/qtest.o > /dev/null

Now the directory is ready for building/bisecting.

I.e. build a single file:

$ docker run --rm \
  -v $PWD:$PWD \
  -w $PWD/build/docker_amd64 \
  -u $UID \
  qemu:debian-amd64 \
    \
    make net/netmap.o

  CC      net/netmap.o
net/netmap.c: In function 'netmap_update_fd_handler':
net/netmap.c:109:5: error: implicit declaration of function
'qemu_set_fd_handler' [-Werror=implicit-function-declaration]
     qemu_set_fd_handler(s->nmd->fd,
     ^~~~~~~~~~~~~~~~~~~
net/netmap.c:109:5: error: nested extern declaration of
'qemu_set_fd_handler' [-Werror=nested-externs]
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'net/netmap.o' failed
make: *** [net/netmap.o] Error 1

Now you can appreciate how powerful Docker can be!

Regards,

Phil.

