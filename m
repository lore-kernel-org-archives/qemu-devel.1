Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5245C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F622083D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="DSuGmk1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F622083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=comstyle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43682 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSDTm-0006J6-9s
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 00:31:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1hSDSL-0005d5-A1
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1hSDQW-0003rz-DI
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:28:01 -0400
Received: from speedy.comstyle.com ([206.51.28.2]:15857 helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1hSDQW-0003qh-5u
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:28:00 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4568Bz3Jlqz4glt;
	Sun, 19 May 2019 00:27:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=subject
	:from:to:cc:references:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=selector1; bh=nxAemSt
	j1rxV5DrCSBsXZFdwm6k=; b=DSuGmk1o+f5XWlAPuZ4Y5kap7NBStMUKt0n4yQo
	M5wmOoW1FvEh+VG82Aqef04Gu3V3egst13KSgVBtnpZqAIHh8euvaponowNtKU2z
	iwQ6RR4K7G9HCSlrM12QsR1Ekkr1KgGS7MYfpJ7okCGl/lWVKkixonpxm+R8Rel6
	dF2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=subject:from
	:to:cc:references:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=selector1; b=E
	K69C75P+S/2jlLZtkvyJWW8ohrD7ivGcuuFZyzKHwqvD7u0PHk1x4v2xHNCkhA64
	voWEdMBf7EB9vJYaxtJ0I+iP+Mob8qIqMPbUtqZZetKYKZjLLifYaPfMPcBXazc1
	1UcFdvKM9tqkrrIcJe1ePCwnhH9R/DqjXG8wFjr+Rc=
Received: from [192.168.3.79] (toroon2719w-lp130-10-70-27-138-202.dsl.bell.ca
	[70.27.138.202])
	(using TLSv1.2 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested) (Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4568Bz0kJbz4gls;
	Sun, 19 May 2019 00:27:39 -0400 (EDT)
From: Brad Smith <brad@comstyle.com>
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
References: <20190510104633.9428-1-kraxel@redhat.com>
	<33bef2cb-e556-a7e1-9b6f-a1d52a8569cc@redhat.com>
	<14d4fec2-e158-a96c-7bd9-2ca960f1656c@comstyle.com>
Message-ID: <fe6f4fe3-63a4-1d65-de2a-3fb03fc4a5df@comstyle.com>
Date: Sun, 19 May 2019 00:27:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <14d4fec2-e158-a96c-7bd9-2ca960f1656c@comstyle.com>
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

I just noticed when I had replied that my e-mail was sent from a differen=
t
name, by accident, as I was testing something with my e-mail client.

On 5/18/2019 5:27 PM, Jim Payne wrote:
> On 5/16/2019 9:04 PM, Thomas Huth wrote:
>
>> On 10/05/2019 12.46, Gerd Hoffmann wrote:
>>> This patch series changes the way virtual machines for test builds ar=
e
>>> managed.=C2=A0 They are created locally on the developer machine now.=
=C2=A0 The
>>> installer is booted on the serial console and the scripts walks throu=
gh
>>> the dialogs to install and configure the guest.
>>>
>>> That takes the download.patchew.org server out of the loop and makes =
it
>>> alot easier to tweak the guest images (adding build dependencies for
>>> example).
>>>
>>> The install scripts take care to apply host proxy settings (from=20
>>> *_proxy
>>> environment variables) to the guest, so any package downloads will be
>>> routed through the proxy and can be cached that way.=C2=A0 This also =
makes
>>> them work behind strict firewalls.
>>>
>>> There are also a bunch of smaller tweaks for tests/vm to fix issues I
>>> was struggling with.=C2=A0 See commit messages of individual patches =
for
>>> details.
>>>
>>> Gerd Hoffmann (13):
>>> =C2=A0=C2=A0 scripts: use git archive in archive-source
>>> =C2=A0=C2=A0 tests/vm: send proxy environment variables over ssh
>>> =C2=A0=C2=A0 tests/vm: use ssh with pty unconditionally
>>> =C2=A0=C2=A0 tests/vm: run test builds on snapshot
>>> =C2=A0=C2=A0 tests/vm: proper guest shutdown
>>> =C2=A0=C2=A0 tests/vm: add vm-boot-{ssh,serial}-<guest> targets
>>> =C2=A0=C2=A0 tests/vm: add DEBUG=3D1 to help text
>>> =C2=A0=C2=A0 tests/vm: serial console support helpers
>>> =C2=A0=C2=A0 tests/vm: openbsd autoinstall, using serial console
>>> =C2=A0=C2=A0 tests/vm: freebsd autoinstall, using serial console
>>> =C2=A0=C2=A0 tests/vm: netbsd autoinstall, using serial console
>>> =C2=A0=C2=A0 tests/vm: fedora autoinstall, using serial console
>>> =C2=A0=C2=A0 tests/vm: ubuntu.i386: apt proxy setup
>> freebsd, netbsd and fedora targets work fine for me, so for the patche=
s
>> 1 - 8 and 10 - 12 :
>>
>> Tested-by: Thomas Huth <thuth@redhat.com>
>>
>> openbsd still fails for me:
>>
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 check-qtest-arm: tests/tmp105-test
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 check-qtest-arm: tests/pca9552-tes=
t
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 check-qtest-arm: tests/ds1338-test
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 check-qtest-arm: tests/microbit-te=
st
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 check-qtest-arm: tests/m25p80-test
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 check-qtest-arm: tests/test-arm-mp=
timer
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 check-qtest-arm: tests/boot-serial=
-test
>> qemu-system-arm: cannot set up guest memory 'ram': Cannot allocate=20
>> memory
>> Broken pipe
>
> How much memory is trying to be allocated here?
>
> The default maximum data size is set to 768MB. If there is a=20
> requirement to go beyond
> that then the default has to be adjusted in /etc/login.conf.
>
> datasize-max and datasize-cur
>
> default:\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :path=3D/usr/bin /bin /usr/s=
bin /sbin /usr/X11R6/bin=20
> /usr/local/bin /usr/local/sbin:\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :umask=3D022:\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :datasize-max=3D768M:\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :datasize-cur=3D768M:\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :maxproc-max=3D256:\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :maxproc-cur=3D128:\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :openfiles-max=3D1024:\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :openfiles-cur=3D512:\
>
>

