Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBCEC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 22:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC99D2067B
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 22:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8BkNQug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC99D2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jccyC-000882-34
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 18:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jccxY-0007fq-7m
 for qemu-devel@nongnu.org; Sat, 23 May 2020 18:49:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57668
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jccxW-0003qA-Ri
 for qemu-devel@nongnu.org; Sat, 23 May 2020 18:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590274177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ntBcWnBTrPIKsrZXjJUeV7Mz13YqyPf9RYP2ylDLIXA=;
 b=R8BkNQugo6X5jhfE1hx/7nAs0wWxfFa4qP80JY8PGeDl5lvk+ZLp8fS7FHV2l6U4XT7U8f
 d94N3bKMjacv3uqfCyjBxaLbelrfHxQUrk4YUCFAPC5cuxV/ST74+TwxcJ7T9KpDMh9OeQ
 9EEPpOuNsbXbh0EdHvQ8UvyqZPitN1g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-EeAgnPKjPKiKVbfqAAFAgw-1; Sat, 23 May 2020 18:49:35 -0400
X-MC-Unique: EeAgnPKjPKiKVbfqAAFAgw-1
Received: by mail-qt1-f198.google.com with SMTP id 19so15912997qtp.8
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 15:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ntBcWnBTrPIKsrZXjJUeV7Mz13YqyPf9RYP2ylDLIXA=;
 b=RXww2SYsIHYcIBhJTDGK2AHgwXzG1jMbCHh6+luH5qUxPaYScb5B4UHYIlUM772tPP
 708DHbCaTFy5HHhHuxg2JzBYZFMdwxLF/Jssmg7TiMtuv/q4csqMCCRaOrZcvQvb5EFS
 ijmfrMEvAbxciYMakXevdaVAy9x2WNUk1ZJSC5oY2m2qdAmoH8RuCqEUOyqVSFVlQMIu
 t7Bxa5diyiQxHdaw2c4BX+01mLiDiB/KvOMGZARBWfCEZWLYnALNencWb3FtprO5wRhp
 1LLIRkZ/HEz7NpFCM7o1torry2pa+fN7qpZrjCffhowUjfkPde+AqKp9CZjeZc9DbB2E
 52Ww==
X-Gm-Message-State: AOAM533Zi1VrzooIIhle7DX36Pe5DbGRNDozFoZ1nCIpZHVJyWcKggBg
 rmxknMd1hz9qOzoUmaYWxSNlxLIu5ZiZcVMogABkQcOiuUJfMQ3ynIrjWstBHvKRcbaVpvQnbbb
 6mkSUc2Rw0duLPDY=
X-Received: by 2002:ac8:5184:: with SMTP id c4mr21388994qtn.356.1590274175047; 
 Sat, 23 May 2020 15:49:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrRqINCJGdVbXdBAWu65laT2pf1B1cQpMoWAhMlx5IzLxFRHJFhYoyHVGz1UZNA8CcflADVg==
X-Received: by 2002:ac8:5184:: with SMTP id c4mr21388984qtn.356.1590274174688; 
 Sat, 23 May 2020 15:49:34 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id d207sm10467217qkc.49.2020.05.23.15.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 15:49:33 -0700 (PDT)
Date: Sat, 23 May 2020 18:49:32 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 0/4] vl: Sync dirty bitmap when system resets
Message-ID: <20200523224932.GA939059@xz-x1>
References: <20200428194219.10963-1-peterx@redhat.com>
 <20200429132607.GJ2834@work-vm> <20200429143227.GC4280@xz-x1>
 <20200502210423.GB6299@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200502210423.GB6299@xz-x1>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 18:49:37
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tian Kevin <kevin.tian@intel.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 02, 2020 at 05:04:23PM -0400, Peter Xu wrote:
> Paolo,
> 
> Do you have any opinion on this series?  Or more generally comments on what's
> your preference to fix the known dirty sync issue with memslot removal would be
> welcomed too.  For my own opinion, I prefer the approach with this series so we
> won't need to touch the kernel at all, and it also paves the way for dirty
> ring.  In all cases, I do think collecting dirty bit of a removing slot is
> slightly awkward already.
> 
> Dave has valid conerns about other cases besides reboot where we might still
> want to keep the dirty bits, on either (1) during BIOS/... boots, or (2) guest
> unmaps of device mmio regions that were backed up by RAM.  I can continue to
> look into theses, however before that I'd appreciate to know whether the
> direction is correct and acceptable.
> 
> IMHO the worst case of a series like this could be that we got regression on
> dirty bit loss, but then we can simply revert the last patch to verify or fix
> it (or we can fix the missing case instead).

Hmm... I didn't find a good and clean way to cover what Dave has mentioned.
Everything would be either ugly or even uglier.  Sad.

Since I didn't get any feedback either on this for some time (or the rest of
the discussion threads or proposals I opened), I think it's time to move on...
I start to feel unwise to continue have the two kvm dirty ring series blocked
due to this extremely corner case of race condition, after all it's not a
specific problem to kvm dirty ring but to both of the methods.  I'll continue
with dirty ring for now, then we fix the race altogether with dirty log when we
find some better solution.

I'll soon post a new QEMU version, keeping the removing memslot sync operation,
but just like dirty log it'll be a best effort sync (e.g. PML ignored).
However I'll comment to at least mention the issues we've found so we can get
to it later again.

Thanks,

-- 
Peter Xu


