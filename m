Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E834C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A302082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EybLcY5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A302082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixFNn-0002Eg-3D
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 14:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ixFMT-0001av-5K
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ixFMQ-00040C-4c
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:20:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52170
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ixFMP-0003ve-OJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580412016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxw7baXKd/ZrzNM5pSZvTs9uCgzhNxpbWo6T9baQa0A=;
 b=EybLcY5QrectSWLIA/BI+i9Mo7WvBgA/+vY/LGHjoPK2i1UfYQvhcsRBIPhuUo/hOknscm
 4E7sgB4nFW94olS1LWCTJzSPMeHp27KRrW2305wVM7TLFwRJqtf+SI7R4n5tC3zmLub/Of
 jFzH14jMCCTzjnnVJI9Ea70xP7qbw6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-_0zaBoT3NOCPczxSvRRjHQ-1; Thu, 30 Jan 2020 14:19:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57C0018C43D9;
 Thu, 30 Jan 2020 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-40.gru2.redhat.com
 [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EBD760BE0;
 Thu, 30 Jan 2020 19:19:48 +0000 (UTC)
Subject: Re: [PATCH 5/6] tests/boot_linux_console: add extract_from_rpm method
To: Liam Merwick <liam.merwick@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-6-git-send-email-liam.merwick@oracle.com>
 <20200130120506.mq6tejv5i2k776k5@steredhat>
 <f60513b8-b974-a46b-f829-993e45a0cff9@oracle.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <d6bed079-9e79-5e64-f7e2-76499f24454c@redhat.com>
Date: Thu, 30 Jan 2020 17:19:47 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f60513b8-b974-a46b-f829-993e45a0cff9@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _0zaBoT3NOCPczxSvRRjHQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, slp@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/30/20 1:34 PM, Liam Merwick wrote:
> On 30/01/2020 12:05, Stefano Garzarella wrote:
>> On Mon, Jan 27, 2020 at 04:36:33PM +0000, Liam Merwick wrote:
>>> Add a method to extract a specified file from an RPM to the test's
>>> working directory and return the path to the extracted file.
>>>
>>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>>> ---
>>> =C2=A0 tests/acceptance/boot_linux_console.py | 14 ++++++++++++++
>>> =C2=A0 1 file changed, 14 insertions(+)
>>>
>>> diff --git a/tests/acceptance/boot_linux_console.py=20
>>> b/tests/acceptance/boot_linux_console.py
>>> index 43bc928b03a2..6af19ae3b14a 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -51,6 +51,20 @@ class BootLinuxConsole(Test):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(cwd)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self.work=
dir + path
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 def extract_from_rpm(self, rpm, path):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Extracts a file from a rpm =
package into the test workdir
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :param rpm: path to the rpm=
 archive
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :param path: path within th=
e rpm archive of the file to be=20
>>> extracted


Might not be obvious to users that `path` should start with '.', and if=20
he/she doesn't do that then extract_from_rpm() will silently fail to=20
extract the file. So could you document that?

>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :returns: path of the extra=
cted file
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cwd =3D os.getcwd()
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(self.workdir)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 process.run("rpm2cpio %s | =
cpio -id %s" % (rpm, path),=20
>>> shell=3DTrue)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(cwd)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self.workdir + '/' +=
 path
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>> =C2=A0=C2=A0=C2=A0=C2=A0 Is the extra slash needed? (just because the ex=
tract_from_deb()
>> =C2=A0=C2=A0=C2=A0=C2=A0 doesn't put it)
>>
>
>
> Yes, I needed to put it in there because the 'path' passed in for
> processing by cpio is a relative patch unlike the deb arg so it
> couldn't be just appended to 'self.workdir' which doesn't end in a '/'.


It is a good practice use the `os.path` module methods when dealing with=20
filesystem paths. So that can be replaced with:

 >>> os.path.normpath(os.path.join('/path/to/workdir', './file/in/rpm'))
'/path/to/workdir/file/in/rpm'

Thanks,

Wainer


>
>
> Regards,
> Liam
>
>
>> Anyway this patch LGTM:
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def do_test_x86_64_machine(self):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=
=3Darch:x86_64
>>> --=20
>>> 1.8.3.1
>>>
>>
>


