Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D1C47256
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 19:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF97206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 19:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwQ5TcAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF97206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW3MV-00023D-49
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 15:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW3La-0001WK-Sa
 for qemu-devel@nongnu.org; Tue, 05 May 2020 15:35:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW3LW-0001mU-J1
 for qemu-devel@nongnu.org; Tue, 05 May 2020 15:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588707312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmrB7amVtEh3tXRGQiq9wzKlE46zbaSNeYgdRPVta2E=;
 b=UwQ5TcAhT9Bt/Li4sf4CuLaIxwOTjqW+w6MNl7K6h76ZiLxnbFZXfBShhvOuvAlAgf06j5
 A+kBc+i0xW9nWdha3ILQ52o0SkbNPD+wCGYQ4LXe/Yh5OTk6TiBEz6lmc/nlhMsP0SgJ68
 +imA9oZDENb4oX6DVT6YF+F9rN/ZbYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-lVnXSmLNMHaoKA11xcwoTg-1; Tue, 05 May 2020 15:35:10 -0400
X-MC-Unique: lVnXSmLNMHaoKA11xcwoTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41263100CCC6;
 Tue,  5 May 2020 19:35:09 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5222170532;
 Tue,  5 May 2020 19:35:07 +0000 (UTC)
Subject: Re: [PATCH v5 07/31] qcow2: Document the Extended L2 Entries feature
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1588699789.git.berto@igalia.com>
 <ad59735f252161ec7ed2f08b30cd517cbfb1d360.1588699789.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <52c059ee-8a80-89af-dbab-ffea3976421e@redhat.com>
Date: Tue, 5 May 2020 14:35:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ad59735f252161ec7ed2f08b30cd517cbfb1d360.1588699789.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 12:38 PM, Alberto Garcia wrote:
> Subcluster allocation in qcow2 is implemented by extending the
> existing L2 table entries and adding additional information to
> indicate the allocation status of each subcluster.
> 
> This patch documents the changes to the qcow2 format and how they
> affect the calculation of the L2 cache size.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   docs/interop/qcow2.txt | 68 ++++++++++++++++++++++++++++++++++++++++--
>   docs/qcow2-cache.txt   | 19 +++++++++++-
>   2 files changed, 83 insertions(+), 4 deletions(-)
> 

> @@ -547,7 +557,8 @@ Standard Cluster Descriptor:
>                       nor is data read from the backing file if the cluster is
>                       unallocated.
>   
> -                    With version 2, this is always 0.
> +                    With version 2 or with extended L2 entries (see the next
> +                    section), this is always 0.

In your cover letter, you said you changed things to tolerate this bit 
being set even with extended L2 entries.  Does this sentence need a tweak?

>   
>            1 -  8:    Reserved (set to 0)
>   
> @@ -584,6 +595,57 @@ file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
>   no backing file or the backing file is smaller than the image, they shall read
>   zeros for all parts that are not covered by the backing file.
>   
> +== Extended L2 Entries ==
> +
> +An image uses Extended L2 Entries if bit 4 is set on the incompatible_features
> +field of the header.
> +
> +In these images standard data clusters are divided into 32 subclusters of the
> +same size. They are contiguous and start from the beginning of the cluster.
> +Subclusters can be allocated independently and the L2 entry contains information
> +indicating the status of each one of them. Compressed data clusters don't have
> +subclusters so they are treated the same as in images without this feature.
> +
> +The size of an extended L2 entry is 128 bits so the number of entries per table
> +is calculated using this formula:
> +
> +    l2_entries = (cluster_size / (2 * sizeof(uint64_t)))
> +
> +The first 64 bits have the same format as the standard L2 table entry described
> +in the previous section, with the exception of bit 0 of the standard cluster
> +descriptor.

Also this sentence.

> +
> +The last 64 bits contain a subcluster allocation bitmap with this format:
> +
> +Subcluster Allocation Bitmap (for standard clusters):
> +
> +    Bit  0 -  31:   Allocation status (one bit per subcluster)

Why two spaces after '-'?  I understand it in situations like '0 -  3' 
in the same list as '16 - 19', to make for a right-justified column, but 
here, everything in the second column is two digits, so the extra 
padding doesn't add anything useful.  Or did you mean to have '64 -  95' 
and '96 - 127', making it obvious that these are the second set of bits 
on top of the existing bits in the first 8 bytes?

> +
> +                    1: the subcluster is allocated. In this case the
> +                       host cluster offset field must contain a valid
> +                       offset.
> +                    0: the subcluster is not allocated. In this case
> +                       read requests shall go to the backing file or
> +                       return zeros if there is no backing file data.
> +
> +                    Bits are assigned starting from the least significant
> +                    one (i.e. bit x is used for subcluster x).
> +
> +        32 -  63    Subcluster reads as zeros (one bit per subcluster)
> +
> +                    1: the subcluster reads as zeros. In this case the
> +                       allocation status bit must be unset. The host
> +                       cluster offset field may or may not be set.
> +                    0: no effect.
> +
> +                    Bits are assigned starting from the least significant
> +                    one (i.e. bit x is used for subcluster x - 32).

Of course, if you change to 64-95 and 96-127, the two sentences mapping 
bit x to subcluster y need adjusting by 64 as well.

> +
> +Subcluster Allocation Bitmap (for compressed clusters):
> +
> +    Bit  0 -  63:   Reserved (set to 0)
> +                    Compressed clusters don't have subclusters,
> +                    so this field is not used.

I can live with the wording as-is (since you did call out the "second 64 
bits" or with the adjusted bit numberings.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


