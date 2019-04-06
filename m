Return-Path: <SRS0=Ux9P=SI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3EEC282CE
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2019 03:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8D121738
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2019 03:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=me.com header.i=@me.com header.b="qD+/cKoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8D121738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49807 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCbdw-0004gb-4b
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 23:05:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hCbd5-0004P8-Dx
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 23:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hCbd3-0000rq-TI
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 23:04:27 -0400
Received: from pv50p00im-hyfv10021501.me.com ([17.58.6.48]:36369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hCbd3-0000jO-HA
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 23:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
	t=1554519862; bh=B61b9hJE5wM+yryVvBxcyUr5Kk8EXSV2Cv2z3ZdCg04=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=qD+/cKoqBjZi/qmYWGykC2Q0mLk4rN7fL1oNvvZQofBvRf32IsFPUfMtf/D7Pcmo9
	B1sGh28Wo2I6gRgLTdx4mQrMgr5HgOvzzK+J46iEFt2IBI1Fj4Enga3dv/79dXLooj
	o9aFXpsVCmTvxb3No992EK9c+idgIL2Vh5Ixe2P7GlFwe6Ww9gmMbQOobJXfdxUjzp
	eJQOerCT8alsDHQZ1HmG+y8GhK03EEsQxV3gqtclX48GzU6q6ETPQumROn8CSewuZ7
	CEo9EXJLYDcPB3a5f0S4+dGAgPjccU9nUznjg1HKbxaXJM7FSDMxKM8TSeeetcoxI6
	qZueA3gzljUsA==
Received: from [192.168.18.7] (unknown [125.36.116.110])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id A46C1B4007B; 
	Sat,  6 Apr 2019 03:04:21 +0000 (UTC)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
In-Reply-To: <C847199D-0619-494F-9376-E8D9C382A4F0@me.com>
Date: Sat, 6 Apr 2019 11:04:18 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE17AB4A-6AF8-4130-937B-301BB974C06A@me.com>
References: <2D646E18-7F28-4F06-9F3D-D5F8A1408FAC@me.com>
	<CAFEAcA_cwH+LH7kzfysQ6Ka98JRX5xf3NgeJo6+0vtuyxP=2ew@mail.gmail.com>
	<7CD2D067-C9F5-435C-97A0-2ED23CA2A20B@me.com>
	<CAFEAcA-VgDpR+jdRFXxw00vtqdd5OZ5N_-xQBC5eFe7LX9M=dQ@mail.gmail.com>
	<C847199D-0619-494F-9376-E8D9C382A4F0@me.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-06_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1812120000 definitions=main-1904060021
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 17.58.6.48
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa: Fix absolute input device
 grabbing issues on Mojave
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
From: Chen Zhang via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Chen Zhang <tgfbeta@me.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190406030418.wWDvwiHqjzE4a8LMTm3UMgFnREl_VMmNvsqonDrdV-k@z>

ping

http://patchwork.ozlabs.org/patch/1058186/

> On Mar 28, 2019, at 10:05 AM, Chen Zhang <tgfbeta@me.com> wrote:
>=20
>=20
>=20
>> On Mar 27, 2019, at 7:37 PM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>=20
>> On Wed, 27 Mar 2019 at 01:09, Chen Zhang <tgfbeta@me.com> wrote:
>>> Just double-checked on a MacMini mid 2011 with macOS 10.13.6, Xcode =
10.1. This NSWindow API did exist, and the patch could be built without =
error.
>>> Searching convertPointFromScreen in Xcode.app=E2=80=99s platform SDK =
showed that it was defined at line 440 in NSWindow.h of =
AppKit.framework.
>>>=20
>>> May I ask what build environment did you use (as printed by =
`xcode-select -p`)?
>>=20
>> manooth$ xcode-select -p
>> /Applications/Xcode.app/Contents/Developer
>>=20
>> But that doesn't seem to be what the C compiler is actually
>> using, because the error messages quote the filename
>> /System/Library/Frameworks/AppKit.framework/Headers/NSWindow.h
>> There is no convertPointFromScreen in that header; but there
>> is one in both of
>>=20
>> =
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Devel=
oper/SDKs/MacOSX.sdk/System/Library/Frameworks/AppKit.framework/Versions/C=
/Headers/NSWindow.h
>>=20
>> and
>> =
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Framewo=
rks/AppKit.framework/Versions/C/Headers/NSWindow.h
>>=20
>> which are the other two copies of NSWindow.h this machine has.
>>=20
>> thanks
>> -- PMM
> This was really odd.
>=20
> I tried to figure out what was wrong with the toolchain and run =
`xcode-select --install` and `xcode-select --switch`. After the this, =
clang failed like what you mentioned.
>=20
> I had to re-configure qemu with --extra-cflags=3D"-isysroot `xcrun =
--show-sdk-path`=E2=80=9D, forcing clang to use the correct SDK root, =
and then it would compile.
>=20
> Thanks and best regards,


