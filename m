Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB406C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 13:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BE7206D5
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 13:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzAqfYpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BE7206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhv2Q-0007ip-Od
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 09:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jhv0Q-0006dK-6d
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 09:06:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44980
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jhv0O-00073f-QC
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 09:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591535187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rg3k7zcNU0HxLnkgFO2a4dC3MJOf0X8IuZEzhwI3gvk=;
 b=QzAqfYpN9zu7TYoQC6xpNtpoJO0ZOW9kC2rs1wqjJjI7dJewWTtL0snCW1XuPhIDXR9DU0
 2NaAFc9FdzJKVvICvWb8aIAUT+Dl8VUR5GRRiXijNAK3A0gQ+3BGqD/EHj7GUzZ5BqrMX+
 btqvZm4j9LBUaz+rydaFeaaL0pkOqls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-Y0Fic94EOsyGBSJIp3r7uw-1; Sun, 07 Jun 2020 09:06:25 -0400
X-MC-Unique: Y0Fic94EOsyGBSJIp3r7uw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8A801009613;
 Sun,  7 Jun 2020 13:06:24 +0000 (UTC)
Received: from starship (unknown [10.35.206.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB2976FF1B;
 Sun,  7 Jun 2020 13:06:22 +0000 (UTC)
Message-ID: <e1abfb5866bb3264dfa8c4ba47d780893f6f81a4.camel@redhat.com>
Subject: Re: [PATCH v7 00/14] LUKS: encryption slot management using amend
 interface
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 07 Jun 2020 16:06:21 +0300
In-Reply-To: <3266027d-8baf-a970-3141-3131106ff98c@redhat.com>
References: <20200518122041.10694-1-mlevitsk@redhat.com>
 <3266027d-8baf-a970-3141-3131106ff98c@redhat.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 08:00:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-06-02 at 18:29 +0200, Max Reitz wrote:
> On 18.05.20 14:20, Maxim Levitsky wrote:
> > Hi!
> > Here is the updated series of my patches, incorporating all the feedback I received.
> 
> You asked me on IRC what to do to get this series to move forward;
> considering I don’t think there were objections from anyone but me on
> v6, there are no further (substantial) objections from anyone on v7, and
> I gave all feedback I had on v6, I don’t think there’s much you can do
> right now.  (Sorry for the delay, but, well, I was on PTO as you know.)
> 
> As usual, I’ll try to get around to see whether I can rebase your series
> myself (because Dan hinted at some conflicts), and whether I feel like
> my comments were appropriately addressed (which I have little doubt
> about).  That’s the plan.
Sorry in advance if I missed any feedback from you. That can happen,
I do make mistakes like anybody of us.


> 
> Note from a couple minutes later: From what I can see, the rebase
> conflicts don’t look too wild, but I don’t feel quite comfortable
> addressing all of them.  There’s a functional one I could address in
> qemu-img.c (patch 3), where we need to bump OPTION_FORCE from 269 to
> 276.  I could do that, but that’s not the only one, unfortunately.
Yes, that conflict is easy.

> 
> Patch 7 needs a bit more extensive modification: First, we need
> %s/bdrv_filter_default_perms/bdrv_default_perms/.  Second, this will
> still not compile, because the .bdrv_child_perm interface has changed.
> BdrvChildRole is now an integer, so we also need
> s/const BdrvChildRole \*/BdrvChildRole /.
> (That gives us the nice side effect of being able to align the second
> line of the bdrv_default_perms() parameters (called from
> block_crypto_child_perms()) on the opening parenthesis.)
I did this.

> 
> Third, it becomes really interesting.  With these changes, it would be
> wrong, because bdrv_default_perms() will then not use the permissions
> for a filter but for an image file with metadata – because that’s what
> the LUKS file child is.
> 
> But that’s actually a bug that’s already there (and that I introduced).
>  It makese sense to fix it in your series here, because to fix it we
> need a dedicated block_crypto_child_perms() function anyway.
> 
> So, well.  Do we want to cheat?  Just let block_crypto_child_perms()
> call bdrv_default_perms() with role=BDRV_CHILD_FILTERED?  That would be
> the previous behavior, but it would also be bad cheating.
> 
> The comment that exists (before patch 7) above
> bdrv_crypto_luks.bdrv_child_perm says that we just want to allow
> share-rw=on, and we could achieve that simply by force-sharing the WRITE
> permission after invoking bdrv_default_perms() with the actual role
> (which is BDRV_CHILD_IMAGE).
> 
> But what about the other stuff that sets
> bdrv_default_perms_for_storage() apart from bdrv_filter_default_perms()?
>  I.e., force-taking WRITE and RESIZE permissions if the file is
> writable; force-taking the CONSISTENT_READ permission because we need
> the metadata; and unsharing the RESIZE permission?
> 
> I think the best thing to do would be to call bdrv_default_perms() with
> the @role passed to block_crypto_child_perms() (i.e., BDRV_CHILD_IMAGE),
> and then relaxing the permissions, that is to share the WRITE and RESIZE
> persmissions, and to perhaps restore the WRITE and RESIZE permissions
> from what’s given to block_crypto_child_perms() (i.e., *nperm &= ~(WRITE
> > RESIZE); *nperm |= perm & (WRITE | RESIZE);), because LUKS doesn’t
> need them unless the image may actually be written.
> 
> (OTOH, force-taking CONSISTENT_READ seems entirely reasonable.)

Could we talk about this on IRC tomorrow? I don't fully understand you here,
and I sort of understood this stuff back when I learned it, but
that was long ago, and since we are talking about permissions here,
plus an necessary hack that luks now have to make, I would like
to understand exactly what I am doing.

Other than that, I rebased the series, and all iotests (with the permission
fix below) are passing.
I'll send the rebased version once we finish the permission thing.


Best regards,
	Maxim Levitsky


PS: This code which is roughtly based on your suggestions,
does pass my test write sharing test, but I don't have much confidence that it is correct:

For example, I don't think that resize permission is needed to be touched,
since resize of the 'luks' image shoudn't have any affect on encryption keys
(since luks image is basically the underlying file minus the header, decrypted,
and we don't really change the encryption key, but a encrypted keyslot which contains it).


    BlockCrypto *crypto = bs->opaque;

    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, nshared);
    /*
     * Ask for consistent read permission so that if
     * someone else tries to open this image with this permission
     * neither will be able to edit encryption keys, since
     * we will unshare that permission while trying to
     * update the encryption keys
     */
    if (!(bs->open_flags & BDRV_O_NO_IO)) {

        *nperm |= BLK_PERM_CONSISTENT_READ;

        *nshared |= (BLK_PERM_WRITE | BLK_PERM_RESIZE);
        *nperm &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
        *nperm |= perm & (BLK_PERM_WRITE | BLK_PERM_RESIZE);
    }
    /*
     * This driver doesn't modify LUKS metadata except
     * when updating the encryption slots.
     * Thus unlike a proper format driver we don't ask for
     * shared write/read permission. However we need it
     * when we are updating the keys, to ensure that only we
     * have access to the device.
     *
     * Encryption update will set the crypto->updating_keys
     * during that period and refresh permissions
     *
     */
    if (crypto->updating_keys) {
        /* need exclusive write access for header update */
        *nperm |= BLK_PERM_WRITE;
        /* unshare read and write permission */
        *nshared &= ~(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE);
    }



