Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E5FC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 21:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5A420675
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 21:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="KYW57jAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5A420675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=comstyle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS6sx-0003Mv-Kp
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 17:28:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1hS6s7-000342-4v
	for qemu-devel@nongnu.org; Sat, 18 May 2019 17:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1hS6s6-000054-15
	for qemu-devel@nongnu.org; Sat, 18 May 2019 17:28:03 -0400
Received: from speedy.comstyle.com ([206.51.28.2]:30052 helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1hS6s5-0008Ti-Nn
	for qemu-devel@nongnu.org; Sat, 18 May 2019 17:28:01 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 455ytK3ftBz4glt;
	Sat, 18 May 2019 17:27:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=subject:to
	:cc:references:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=selector1; bh=A9FX4Vr
	RmZWTTMnlWGyMYmTprQE=; b=KYW57jAkDfiA490bdENqr5LCnR5BN6joa2O12Za
	2Z0Vo3kFG0ISqcQEsgU/EtYsXM9sN4X43Toca4t5Cy5FrCsRmRM3VhljtWxF4e+4
	NqHahwLXINb3kFMKjSd/W9Uu5Uinpzfu7IhR//qX5ZoVrOmovRhv+Y3q4M/BV21U
	zp2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=subject:to
	:cc:references:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=selector1; b=m
	7K1sMdXIEw+K7bhaf7LM+p46tnngjpJBZVe15ACdZvR5gvrqQ1w8ApxNp3qba79u
	NnmnWEwDWYQ+U1SRU6o/wFNEmClYGE5ZpB9viLaAciLAAFoqKldoc7OFqbyeRGMN
	jwAXHL632EXJ2oJJUxUB4bM7RauevUXhtpkv4rIFE4=
Received: from [192.168.180.2] (toroon0812w-lp130-06-74-12-34-161.dsl.bell.ca
	[74.12.34.161]) (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested) (Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 455ytK14Sdz4gls;
	Sat, 18 May 2019 17:27:37 -0400 (EDT)
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
References: <20190510104633.9428-1-kraxel@redhat.com>
	<33bef2cb-e556-a7e1-9b6f-a1d52a8569cc@redhat.com>
From: Jim Payne <brad@comstyle.com>
Message-ID: <14d4fec2-e158-a96c-7bd9-2ca960f1656c@comstyle.com>
Date: Sat, 18 May 2019 17:27:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <33bef2cb-e556-a7e1-9b6f-a1d52a8569cc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 206.51.28.2
Subject: Re: [Qemu-devel] QEMU on OpenBSD is broken?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Ed Maste <emaste@freebsd.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/2019 9:04 PM, Thomas Huth wrote:

> On 10/05/2019 12.46, Gerd Hoffmann wrote:
>> This patch series changes the way virtual machines for test builds are
>> managed.  They are created locally on the developer machine now.  The
>> installer is booted on the serial console and the scripts walks throug=
h
>> the dialogs to install and configure the guest.
>>
>> That takes the download.patchew.org server out of the loop and makes i=
t
>> alot easier to tweak the guest images (adding build dependencies for
>> example).
>>
>> The install scripts take care to apply host proxy settings (from *_pro=
xy
>> environment variables) to the guest, so any package downloads will be
>> routed through the proxy and can be cached that way.  This also makes
>> them work behind strict firewalls.
>>
>> There are also a bunch of smaller tweaks for tests/vm to fix issues I
>> was struggling with.  See commit messages of individual patches for
>> details.
>>
>> Gerd Hoffmann (13):
>>    scripts: use git archive in archive-source
>>    tests/vm: send proxy environment variables over ssh
>>    tests/vm: use ssh with pty unconditionally
>>    tests/vm: run test builds on snapshot
>>    tests/vm: proper guest shutdown
>>    tests/vm: add vm-boot-{ssh,serial}-<guest> targets
>>    tests/vm: add DEBUG=3D1 to help text
>>    tests/vm: serial console support helpers
>>    tests/vm: openbsd autoinstall, using serial console
>>    tests/vm: freebsd autoinstall, using serial console
>>    tests/vm: netbsd autoinstall, using serial console
>>    tests/vm: fedora autoinstall, using serial console
>>    tests/vm: ubuntu.i386: apt proxy setup
> freebsd, netbsd and fedora targets work fine for me, so for the patches
> 1 - 8 and 10 - 12 :
>
> Tested-by: Thomas Huth <thuth@redhat.com>
>
> openbsd still fails for me:
>
>    TEST    check-qtest-arm: tests/tmp105-test
>    TEST    check-qtest-arm: tests/pca9552-test
>    TEST    check-qtest-arm: tests/ds1338-test
>    TEST    check-qtest-arm: tests/microbit-test
>    TEST    check-qtest-arm: tests/m25p80-test
>    TEST    check-qtest-arm: tests/test-arm-mptimer
>    TEST    check-qtest-arm: tests/boot-serial-test
> qemu-system-arm: cannot set up guest memory 'ram': Cannot allocate memo=
ry
> Broken pipe

How much memory is trying to be allocated here?

The default maximum data size is set to 768MB. If there is a requirement=20
to go beyond
that then the default has to be adjusted in /etc/login.conf.

datasize-max and datasize-cur

default:\
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :path=3D/usr/bin /bin /usr/sb=
in /sbin /usr/X11R6/bin=20
/usr/local/bin /usr/local/sbin:\
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :umask=3D022:\
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :datasize-max=3D768M:\
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :datasize-cur=3D768M:\
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :maxproc-max=3D256:\
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :maxproc-cur=3D128:\
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :openfiles-max=3D1024:\
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :openfiles-cur=3D512:\



