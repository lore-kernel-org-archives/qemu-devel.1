Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC201C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F512311E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AP6/0BfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F512311E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLW3D-000144-SG
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 14:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kLW1U-0000aC-8N
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 14:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kLW1R-0007nX-LX
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 14:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600972272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=muaRBAXOArsmWzIds0BDyHmJK2U8URkrzfnp+QCHwaI=;
 b=AP6/0BfWtAwkekICUs4uAY7nSlQyNyUhF0dh/PVLQAKFrghqdI9eQnhplzDLuVx4WTF2Me
 CYhowK3YuShx68NKHjp2tO6V/8EsIJnrJtqARXMbDo+SwFwChI0pGEdhoNfu48GndMR71i
 aAYGjUS9U22QUy/2IaQyEIDNK7j7z5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-v22o65T9MNCEqPJKYpUndg-1; Thu, 24 Sep 2020 14:31:10 -0400
X-MC-Unique: v22o65T9MNCEqPJKYpUndg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61B186408A
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 18:31:09 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3740B5D9D2;
 Thu, 24 Sep 2020 18:31:03 +0000 (UTC)
Message-ID: <38083a95d85f5c057f80d4190f592dc358951638.camel@redhat.com>
Subject: Re: [RFC DOCUMENT 00/12] kubevirt-and-kvm: Add documents
From: Andrea Bolognani <abologna@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, 
 libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Thu, 24 Sep 2020 20:31:01 +0200
In-Reply-To: <83b1a4fd-9d06-8a9a-974b-6314d370db21@redhat.com>
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
 <83b1a4fd-9d06-8a9a-974b-6314d370db21@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: crobinso@redhat.com, rmohr@redhat.com, vromanso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-09-22 at 11:29 +0200, Philippe Mathieu-Daudé wrote:
> Hi Andrea,

Hi Philippe, and sorry for the delay in answering!

First of all, thanks for taking the time to go through the documents
and posting your thoughts. More comments below.

> Thanks a lot for this documentation, I could learn new things,
> use cases out of my interest area. Useful as a developer to
> better understand how are used the areas I'm coding. This
> shorten a bit that gap between developers and users.
> 
> What would be more valuable than a developer review/feedback is
> having feedback from users and technical writers.
> Suggestion: also share it on qemu-discuss@nongnu.org which is
> less technical (maybe simply repost the cover and link to the
> Wiki).

More eyes would obviously be good, but note that these are really
intended to improve the interactions between QEMU/libvirt and
KubeVirt, so the audience is ultimately developers. Of course you
could say that KubeVirt developers *are* users when it comes to
QEMU/libvirt, and you wouldn't be wrong ;) Still, qemu-devel seems
like the proper venue.

> What is not obvious in this cover (and the documents pasted on
> the list) is there are schema pictures on the Wiki pages which
> are not viewable and appreciable via an email post.

You're right! I was pretty sure I had a line about that somewhere in
there but I guess it got lost during editing. Hopefully the URL at
the very beginning of each document caused people to browse the HTML
version.

> I had zero knowledge on Kubernetes. I have been confused by their
> use in the introduction...
> 
> From Index:
> 
> "The intended audience is people who are familiar with the traditional
> virtualization stack (QEMU plus libvirt), and in order to make it
> more approachable to them comparisons, are included and little to no
> knowledge of KubeVirt or Kubernetes is assumed."
> 
> Then in Architecture's {Goals and Components} there is an assumption
> Kubernetes is known. Entering in Components, Kubernetes is briefly
> but enough explained.
> 
> Then KubeVirt is very well explained.

I guess the sections in the Index you're referring to assume that you
know that Kubernetes is somehow connected to containers, and that
it's a clustered environment. Anything else I missed?

Perhaps we could move the contents of

  https://gitlab.cee.redhat.com/abologna/kubevirt-and-kvm/-/blob/master/Components.md#kubernetes

to a small document that's linked to near the very top. Would that
improve things, in your opinion?

> Sometimes the "Other topics" category is confusing, it seems out
> of the scope of the "better understanding and documenting the
> interactions between KubeVirt and KVM" and looks like left over
> notes.

That's probably because they absolutely are O:-)

> Maybe renaming the "Other topics" section would help.
> "Unanswered questions", "Other possibilities to investigate",...

This sounds sensible :)

Thanks again for your feedback!

-- 
Andrea Bolognani / Red Hat / Virtualization


