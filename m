Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C2BC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53462073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXnz/HtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53462073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1uZy-0008JX-SD
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1uZK-0007fB-Ri
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1uZJ-0004Nw-6i
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:08:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44511
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1uZJ-0004MX-2i
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581523732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Koj2TeVHcfDlnm3DYsSXd9Ot7nAtrMsJfGscxpGO4cE=;
 b=GXnz/HtY9DBk8a5sUr+HHtQF/yav5KAIZj2rAuwGEi3lWV+mT2XimvRCyQvAEEQ6C8SYgu
 n5QiFrV2gjaX2sbx3nY8p/vUBtDjzWONijS2RaQNHkX5PX/S3Xz+zg7+CooGkN6m70/SFd
 NTgrA1UihlKW05SEX93LQLeQflR81AY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-ZFfkOUlAMyi6tjLOmG8Zgw-1; Wed, 12 Feb 2020 11:08:47 -0500
Received: by mail-wm1-f71.google.com with SMTP id t17so901975wmi.7
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RcaR8y3ujYbq/6QJYQrKx3QCY9kJm2CWobpchXNDC7k=;
 b=f2fcEcVlvcNdD+wUw/D92R2nj08r7fV/07t4ROr0aAk7piR5/S+arn3E7zcdHsGE7H
 qrvqvuB0COWThCme40ABb3bnGqgNPrM2BbozmjlHsoMTNeMDB4y0l2B1yjKK7PDbv2d1
 JHUgASuzTMuHym0tRQKF0rLvUO+PDM3ABSYl/TvZipndNmT0LG9vSERAEUUfN5I92oFI
 NK/gkIgdreLwqin1nYhbXjo3iTbqOOyVEwo0NBBVAhIrZizwymoTpS8QS5Vz3VkWoYFx
 PAJe1mJuIWcmrQl9MDVjc8f9+pLYwdWx3zB+e8sq7vgAVL9W7QMSgNMAfqhSmGNq6QfF
 yyrg==
X-Gm-Message-State: APjAAAXHzF6eBR0LEPtQLdna5usZTwgnp/qcmsgsLSocrdFS3C5AC9qH
 W9RqU4Lu58I+JnmdPBo8rLSX+usDwGyuege/zn7B8bEwjvuti3Beo4sDGUSfnfbaFUKGWF5fS8P
 xS61R9yhG+QSvj5s=
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr13320066wma.5.1581523725750; 
 Wed, 12 Feb 2020 08:08:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqzG3lNTCZOsvsHpBzIzRXGbrBuAc5twg6314hrnlEliAQaFGbEtoqzOTbm9M0rQX5Nz7pV26Q==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr13320035wma.5.1581523725409; 
 Wed, 12 Feb 2020 08:08:45 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i204sm1345538wma.44.2020.02.12.08.08.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 08:08:44 -0800 (PST)
Subject: Re: [PATCH v2] linux-user: implement TARGET_SO_PEERSEC
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200204211901.1731821-1-laurent@vivier.eu>
 <713318de-21ee-4137-0580-c6d852bea008@redhat.com>
 <93a00c06-f42d-0c7d-79a4-0dcd1bc488c5@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <67dbdf8f-0565-32f0-bfeb-0ca7d694d948@redhat.com>
Date: Wed, 12 Feb 2020 17:08:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <93a00c06-f42d-0c7d-79a4-0dcd1bc488c5@vivier.eu>
Content-Language: en-US
X-MC-Unique: ZFfkOUlAMyi6tjLOmG8Zgw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?Q?Matthias_L=c3=bcscher?= <lueschem@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 5:03 PM, Laurent Vivier wrote:
> Le 12/02/2020 =C3=A0 16:56, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> On 2/4/20 10:19 PM, Laurent Vivier wrote:
>>> "The purpose of this option is to allow an application to obtain the
>>> security credentials of a Unix stream socket peer.=C2=A0 It is analogou=
s to
>>> SO_PEERCRED (which provides authentication using standard Unix
>>> credentials
>>> of pid, uid and gid), and extends this concept to other security
>>> models." -- https://lwn.net/Articles/62370/
>>>
>>> Until now it was passed to the kernel with an "int" argument and
>>> fails when it was supported by the host because the parameter is
>>> like a filename: it is always a \0-terminated string with no embedded
>>> \0 characters, but is not guaranteed to be ASCII or UTF-8.
>>>
>>> I've tested the option with the following program:
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cc -o getpeercon getpeercon.c
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <stdio.h>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <sys/types.h>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <sys/socket.h>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <netinet/in.h>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <arpa/inet.h>
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 int main(void)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fd;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sockaddr_in se=
rver, addr;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 socklen_t len;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char buf[256];
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D socket(PF_INET=
, SOCK_STREAM, 0);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fd =3D=3D -1) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 perror("socket");
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 1;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 server.sin_family =3D=
 AF_INET;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet_aton("127.0.0.1"=
, &server.sin_addr);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 server.sin_port =3D h=
tons(40390);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 connect(fd, (struct s=
ockaddr*)&server, sizeof(server));
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D sizeof(buf);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D getsockopt(fd=
, SOL_SOCKET, SO_PEERSEC, buf, &len);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -1) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 perror("getsockopt");
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 1;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%d %s\n", len=
, buf);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> On host:
>>>
>>>  =C2=A0=C2=A0 $ ./getpeercon
>>>  =C2=A0=C2=A0 33 system_u:object_r:unlabeled_t:s0
>>>
>>> With qemu-aarch64/bionic without the patch:
>>>
>>>  =C2=A0=C2=A0 $ ./getpeercon
>>>  =C2=A0=C2=A0 getsockopt: Numerical result out of range
>>>
>>> With the patch:
>>>
>>>  =C2=A0=C2=A0 $ ./getpeercon
>>>  =C2=A0=C2=A0 33 system_u:object_r:unlabeled_t:s0
>>>
>>> Bug: https://bugs.launchpad.net/qemu/+bug/1823790
>>> Reported-by: Matthias L=C3=BCscher <lueschem@gmail.com>
>>> Tested-by: Matthias L=C3=BCscher <lueschem@gmail.com>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>
>>> Notes:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 v2: use correct length in unlock_user()
>>>
>>>  =C2=A0 linux-user/syscall.c | 22 ++++++++++++++++++++++
>>>  =C2=A0 1 file changed, 22 insertions(+)
>>>
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index d60142f0691c..c930577686da 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -2344,6 +2344,28 @@ static abi_long do_getsockopt(int sockfd, int
>>> level, int optname,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case TARGET_SO_PEERSEC: {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cha=
r *name;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(get_user_u32(len, optlen)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -TARGET_EFAULT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(len < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -TARGET_EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nam=
e =3D lock_user(VERIFY_WRITE, optval_addr, len, 0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(!name) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -TARGET_EFAULT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lv =
=3D len;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D get_errno(getsockopt(sockfd, level, SO_PEERSEC,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 name, &lv));
>>
>> Can we get lv > len?
>=20
> No:
>=20
> getsockopt(2)
>=20
> "For  getsockopt(), optlen is a value-result argument, initially
> containing the size of the buffer pointed to by optval, and modified on
> return to  indicate the  actual  size  of  the value returned."
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(put_user_u32(lv, optlen)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -TARGET_EFAULT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unl=
ock_user(name, optval_addr, lv);
>>
>> Maybe safer to use len instead of lv here?
>=20
> No:
>=20
> this is the length of the buffer we must copy back to the user. Kernel
> has only modified lv length, not len.

So we can simplify the TARGET_SO_LINGER case then.

>=20
> linux-user/qemu.h
>=20
> /* Unlock an area of guest memory.  The first LEN bytes must be
>     flushed back to guest memory. host_ptr =3D NULL is explicitly
>     allowed and does nothing. */
> static inline void unlock_user(void *host_ptr, abi_ulong guest_addr,
>                                 long len)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


