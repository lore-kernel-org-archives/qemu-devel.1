Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8001DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F522253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Kjm7FPos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F522253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuand-0003AU-FK
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iuamk-0002jS-II
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iuamj-00019y-C9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:36:30 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:39985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iuami-00018O-TS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Fivqf3Ds+3Sv4LVdV0stywn4pEK6AJgcLXwa1ZoxYXI=; b=Kjm7FPos62Luse3OlUuRanmnQC
 K/e4LfwedW6SKqyLxF1yrmTWTakz14B5a0TN+Z8ARvACPnecJmuGsm+vPwqi5pOEtQ6ZVeTUlUhGx
 wc6VS0Ew+cqx455upSg1tT2sFc+x6oXN1Peatk5vgQ2H3zdrJBAGE0ZA5gY0YsRJ7nDEXqoAIL5JA
 QTTAcK+RM9zvXI0BpTzwmtt3u3lsLS1y4i26Blmw1af8w9qgtR7xUPmRhLaXY58QX94qyjsx2GTu9
 wa9DnIAA8OoWa5pXGF5AtNMwdqsImsFYTCtnMkY9bz1hh+0D09HkJY/L1FXkyocbd633roxWJijLk
 YhZWI5qrNleM71MCsNCUTF7CqI7ykKsT2j0I+1XANAG45RU+8pa9A8hoKIFARslelKelUXzB5Zwnb
 W/q837uZc6Wk4vPav+/xqtk/GvVDMI5xyE9AyAjUwBf77f5C+W0kEmlzOy8mbPnA4Uts6ZhTPdycm
 /RZeCir2z+swHuJtXdvUqjiD8bnt+MVlT4QJhhKqn5b6yVILS0/u/aLGWI387pbUYJYqgC0V4kw0C
 ubHP2kx1fIrtduAjRgpZak/mpV5aYtLFDe+zTK/aV8eITeK8UOEggTxzQ6gFKFvG+Io32WdXvwg3R
 BAKlS2gYoWFy/0wCwU+UqF59Vo4CieLpodrFofri0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 07/11] tests/virtio-9p: failing splitted readdir test
Date: Thu, 23 Jan 2020 12:36:12 +0100
Message-ID: <23580535.7v2ZZEAp5V@silver>
In-Reply-To: <20200122235954.1305faab@bahia.lan>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <4dc3706db1f033d922e54af8c74a81211de8b79f.1579567020.git.qemu_oss@crudebyte.com>
 <20200122235954.1305faab@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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

On Mittwoch, 22. Januar 2020 23:59:54 CET Greg Kurz wrote:
> On Tue, 21 Jan 2020 01:17:35 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > This patch is not intended to be merged. It resembles
> > an issue (with debug messages) where the splitted
> > readdir test fails because server is interrupted with
> > transport error "Failed to decode VirtFS request type 40",
> 
> Ok. When we send a new request, we call:
> 
> uint32_t qvirtqueue_add(QTestState *qts, QVirtQueue *vq, uint64_t data,
>                         uint32_t len, bool write, bool next)
> {
>     uint16_t flags = 0;
>     vq->num_free--;
> 
> [...]
> 
>     return vq->free_head++; /* Return and increase, in this order */
> }

Ah, I see!

> where vq->num_free is the number of available buffers (aka. requests) in
> the vq and vq->free_head the index of the next available buffer. The size
> of the vq of the virtio-9p device is MAX_REQ (128) buffers. The driver
> is very simple and doesn't care to handle the scenario of a full vq,
> ie, num_free == 0 and free_head is past the vq->desc[] array. It seems
> that count=128 generates enough extra requests to reach the end of the
> vq. Hence the "decode" error you get. Maybe an assert(vq->num_free) in
> qvirtqueue_add() would make that more clear ?

So just that I get it right; currently the 9pfs test suite writes to a 
ringbuffer with every request (decreasing the free space in the ringbuffer), 
but it never frees up that space in the ringbuffer?

> Not sure it is worth to address this limitation though. Especially since
> count=128 isn't really a recommended choice in the first place. 

Well, if that's what happens with the ringbuffer, it would need to be 
addressed somehow anyway, otherwise it would be impossible to add more 9pfs 
tests, since they would hit the ringbuffer limit as well at a certain point, 
no matter how simple the requests are.

Wouldn't it make sense to reset the ringbuffer after every succesful, 
individual 9pfs test?

> It has
> more chances to cause a disconnect if the server needs to return a longer
> file name (which is expected since most fs have 255 character long file
> names).

Well, this test is dependent on what's provided exactly by the synth driver 
anyway. So I don't see the value 128 as a problem here. The readdir/split test 
could even determine the max. length of a file provided by synth driver if you 
are concerned about that, because the file name template macro 
QTEST_V9FS_SYNTH_READDIR_FILE used by synth driver is public.

And BTW it is not really this specific 'count' value (128) that triggers this 
issue, if you just run the readdir/split test with i.e.:

	const uint32_t vcount[] = { 128 };

then you won't trigger this test environment issue.

Best regards,
Christian Schoenebeck



