Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A33C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC352187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC352187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihVy-00083J-Jz
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hihTi-0006C3-F3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hihTg-0003kM-FN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:47:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hihTU-0003aq-L0; Wed, 03 Jul 2019 11:47:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1674330821A3;
 Wed,  3 Jul 2019 15:46:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-252.ams2.redhat.com [10.36.116.252])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74C854A4;
 Wed,  3 Jul 2019 15:46:51 +0000 (UTC)
Date: Wed, 3 Jul 2019 17:46:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190703154649.GA7764@linux.fritz.box>
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-2-dplotnikov@virtuozzo.com>
 <f41f5552-a625-3306-ba3b-50d60dbefe22@redhat.com>
 <030cb268-263d-580b-bd75-ec3bc973799b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030cb268-263d-580b-bd75-ec3bc973799b@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 03 Jul 2019 15:47:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 1/3] qcow2: introduce compression type
 feature
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.07.2019 um 17:01 hat Denis Plotnikov geschrieben:
> On 03.07.2019 17:14, Eric Blake wrote:
> > On 7/3/19 6:00 AM, Denis Plotnikov wrote:
> >> diff --git a/block/qcow2.c b/block/qcow2.c
> >> index 3ace3b2209..921eb67b80 100644
> >> --- a/block/qcow2.c
> >> +++ b/block/qcow2.c
> >> @@ -1202,6 +1202,47 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
> >>       return ret;
> >>   }
> >>   
> >> +static int check_compression_type(BDRVQcow2State *s, Error **errp)
> >> +{
> >> +    bool is_set;
> >> +    int ret = 0;
> >> +
> >> +    switch (s->compression_type) {
> >> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> >> +        break;
> >> +
> >> +    default:
> >> +        if (errp) {
> > Useless check for errp being non-NULL.  What's worse, if the caller
> > passes in NULL because they don't care about the error, then your code
> > behaves differently.  Just call error_setg() and return -ENOTSUP
> > unconditionally.
> ok
> > 
> >> +            error_setg(errp, "qcow2: unknown compression type: %u",
> >> +                       s->compression_type);
> >> +            return -ENOTSUP;
> >> +        }
> >> +    }
> >> +
> >> +    /*
> >> +     * with QCOW2_COMPRESSION_TYPE_ZLIB the corresponding incompatible
> >> +     * feature flag must be absent, with other compression types the
> >> +     * incompatible feature flag must be set
> > Is there a strong reason for forbid the incompatible feature flag with
> > ZLIB?
> The main reason is to guarantee image opening for older qemu if 
> compression type is zlib.
> > Sure, it makes the image impossible to open with older qemu, but
> > it doesn't get in the way of newer qemu opening it. I'll have to see how
> > your spec changes documented this, to see if you could instead word it
> > as 'for ZLIB, the incompatible feature flag may be absent'.
> I just can't imagine when and why we would want to set incompatible 
> feature flag with zlib. Suppose we have zlib with the flag set, then
> older qemu can't open the image although it is able to work with the 
> zlib compression type. For now, I don't understand why we should make 
> such an artificial restriction.

We don't want to create such images, but we want to keep our code as
simple as possible.

As your patch shows, forbidding the case is more work than just allowing
it. So if external software can create such images, and it would just
automatically work in QEMU, then why do the extra work to articifially
forbid this?

(Actually, it's likely that on the first header update, QEMU would just
end up dropping the useless flag, so we even "fix" such images.)

> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> index 7ccbfff9d0..6aa8b99993 100644
> >> --- a/qapi/block-core.json
> >> +++ b/qapi/block-core.json
> >> @@ -78,6 +78,8 @@
> >>   #
> >>   # @bitmaps: A list of qcow2 bitmap details (since 4.0)
> >>   #
> >> +# @compression-type: the image cluster compression method (since 4.1)
> >> +#
> >>   # Since: 1.7
> >>   ##
> >>   { 'struct': 'ImageInfoSpecificQCow2',
> >> @@ -89,7 +91,8 @@
> >>         '*corrupt': 'bool',
> >>         'refcount-bits': 'int',
> >>         '*encrypt': 'ImageInfoSpecificQCow2Encryption',
> >> -      '*bitmaps': ['Qcow2BitmapInfo']
> >> +      '*bitmaps': ['Qcow2BitmapInfo'],
> >> +      '*compression-type': 'Qcow2CompressionType'
> > Why is this field optional? Can't we always populate it, even for older
> > images?
> Why we should if we don't care ?

I was trying too check what the condition is under which the field will
be present in the output, but I couldn't find any code for it.

So it looks like this patch never makes use of the field and it's dead
code?

Kevin

