Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDBDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8C62065F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTIBfh80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8C62065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyh7F-0001b0-9V
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 15:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyh6g-0001AY-Hv
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:42:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55558
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyh6e-0002gF-Gf
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595533335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJCGgsyId6k/YdYtv828Oejs1prKUHWGt2iDKSGH6P0=;
 b=VTIBfh80DIB3wLWP1oOikSfl0ex4hOJGXqT1+iCr3GhzWeZflNsC5+FGYfmDgG8aMUdTse
 ULfQ0bpp9bjeRM2ZwuMkc3YW78zYYAl7qCzQJWj49znOE+V6aRSjKYY2VVDQ8eoXk7kvKR
 8GrQ3/PZNsKaidP4bIiLjycj06R5eaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-N1lX02mzPzSpdkhTZeU1AA-1; Thu, 23 Jul 2020 15:42:11 -0400
X-MC-Unique: N1lX02mzPzSpdkhTZeU1AA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C6B280046C;
 Thu, 23 Jul 2020 19:42:10 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4F3B1001B0B;
 Thu, 23 Jul 2020 19:42:08 +0000 (UTC)
Subject: Re: [PATCH v11 00/11] iotests: Dump QCOW2 dirty bitmaps metadata
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <20743b55-8eeb-3cac-86db-eab8c2bcd4ea@redhat.com>
Date: Thu, 23 Jul 2020 14:42:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 3:14 AM, Andrey Shinkevich wrote:
> Add dirty bitmap information to QCOW2 metadata dump in the qcow2_format.py.
> 
> v10:
>    01: Fixing of issues in QCOW2 extension classes noted by Vladimir.
>    02: Reading bitmap tables was moved into Qcow2BitmapTable class.
>    03: Handling '-j' key was moved into "if __name__" section.
>    04: Making copy of __dict__ was replaced with the method to_dict().
>    05: Qcow2HeaderExtensionsDoc is introduced in the separate patch.
> 
> Andrey Shinkevich (11):
>    qcow2: Fix capitalization of header extension constant.
>    qcow2_format.py: make printable data an extension class member
>    qcow2_format.py: change Qcow2BitmapExt initialization method
>    qcow2_format.py: dump bitmap flags in human readable way.
>    qcow2_format.py: Dump bitmap directory information
>    qcow2_format.py: pass cluster size to substructures
>    qcow2_format.py: Dump bitmap table serialized entries
>    qcow2.py: Introduce '-j' key to dump in JSON format
>    qcow2_format.py: collect fields to dump in JSON format
>    qcow2_format.py: introduce Qcow2HeaderExtensionsDoc class
>    qcow2_format.py: support dumping metadata in JSON format
> 
>   block/qcow2.c                      |   2 +-
>   docs/interop/qcow2.txt             |   2 +-
>   tests/qemu-iotests/qcow2.py        |  18 ++-
>   tests/qemu-iotests/qcow2_format.py | 221 ++++++++++++++++++++++++++++++++++---
>   4 files changed, 220 insertions(+), 23 deletions(-)

I still don't see any obvious coverage of the new output, which makes it 
harder to test (I have to manually run qcow2.py on a file rather than 
seeing what changes in a ???.out file).  I know we said back in v9 that 
test 291 is not the right test, but that does not stop you from adding a 
new test just for that purpose.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


