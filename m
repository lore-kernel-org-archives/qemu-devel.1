Return-Path: <SRS0=Ux9P=SI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58960C282CE
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2019 03:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD7021738
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2019 03:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=me.com header.i=@me.com header.b="FOkQtTlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD7021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49827 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCbfS-0005vt-BX
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 23:06:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hCbeg-0005J0-K6
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 23:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hCbef-0002XY-C5
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 23:06:06 -0400
Received: from pv50p00im-hyfv10011601.me.com ([17.58.6.43]:37878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hCbee-0002Ww-Nu
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 23:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
	t=1554519963; bh=v4xH5v4DicKAXNlqaLXOxwpiSdycj3iQLf78+nfATnA=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
	b=FOkQtTlqOs/APaSwMyfNTNagUz0Ed9OpSKzF1oBax4GjeEOtD/vIJFu9e/dlekclR
	dp0p7rjYuMf/KOf/rnkeJCJgVRaYWSYaCyE9nQyhlAC0I+TuosW1h4vH1MFnhfbctr
	5KPjIzX5noYWuJ4EvYE5MIlp5FaaTxNTcGygiMzObg2Zz4tSWgiVYTABWdbw2h8q9O
	Xdfw6DHd5WV3nwZpWP2Lm/XgDzYdNDnsSXHjG7xoZHDW6lZUS5e/TTKPWm58LZyJDP
	ZnSIH5fVrVY3RoT3TGi0vXXm01Np2vSWXO12Han3G+dhK97L8n3cjSgMN+8MksT7ZT
	/b6mUvNQnFJ+Q==
Received: from [192.168.18.7] (unknown [125.36.116.110])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 76F5438009D; 
	Sat,  6 Apr 2019 03:06:02 +0000 (UTC)
Message-Id: <F54427F0-DF20-4F0B-A450-8615E96E1155@me.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Date: Sat, 6 Apr 2019 11:05:59 +0800
In-Reply-To: <69264EAD-C8B6-4EFC-8B31-CA96FA5E3893@me.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <176E53D9-50B8-405C-82FF-5247342264C1@me.com>
	<CAFEAcA-0HHD30gBgPT6JKX2yj2S7a03cs8FYOvwgDgXZ_mr=oQ@mail.gmail.com>
	<69264EAD-C8B6-4EFC-8B31-CA96FA5E3893@me.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-06_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1812120000 definitions=main-1904060021
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 17.58.6.43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa: Fix mouse grabbing in fullscreen
 mode for relative input device
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
Message-ID: <20190406030559.yQEJhVmzSIDpKz67XPyl08_bvHQA54rd1SeHI7r2Csg@z>

ping

http://patchwork.ozlabs.org/patch/1059842/

> On Mar 27, 2019, at 10:00 AM, Chen Zhang <tgfbeta@me.com> wrote:
>=20
>=20
>=20
>> On Mar 27, 2019, at 12:20 AM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>=20
>> On Thu, 21 Mar 2019 at 07:10, Chen Zhang <tgfbeta@me.com> wrote:
>>>=20
>>> In fullscreen mode, the window property of cocoaView may not be the =
key
>>> window, and the current implementation would not grab mouse in
>>> fullscreen mode after left clicks on relative input devices.
>>>=20
>>> This patch used isFullscreen value as a short-cirtuit condition for
>>> relative input device grabbing.
>>>=20
>>> Note that this patch should be tested after applying a previous =
patch
>>> which fixed event location conversion for relative input devices.
>>>=20
>>> Signed-off-by: Chen Zhang <tgfbeta@me.com>
>>=20
>> Can you explain in more detail when this patch makes a
>> difference, please? (for instance, a set of instructions
>> for reproducing the issue).
>>=20
>=20
>> I'm confused, because in the toggleFullScreen method, when
>> we switch to full screen mode (which is the only place where
>> we set isFullscreen to true) we always do a [self grabMouse].
>> So if we get into the event handling function and isFullscreen
>> is true, I think the mouse should already be grabbed. What
>> am I missing ?
> Hi,
>=20
> In fullscreen mode, when the mouse is un-grabbed by pressing =
Cmd-Opt-g, it would not be re-grabbed by clicks in the view, as the =
window of the view would not be key window by then.
>=20
> BTW, the Ctrl-Alt-Xs in ui/cocoa.m was confusing in the context. =
Should they be replaced by Cmd-Opt-Xs?
>>=20
>> thanks
>> -- PMM
>=20
> Best Regards,

