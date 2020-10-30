Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D57C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D018A20704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcJ8mek7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D018A20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYarh-0007F4-K7
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 16:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYaqd-0006Yv-Vt
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYaqb-0007CK-DA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604089082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxPvQuHBYJN22PqkRkX0r99P3BbYD+8agzhIiKSPU3M=;
 b=ZcJ8mek7nfFE0ZH4mC9WZc35kiGGwhMl7okO8Sw7cWOzMR6Mik/atqt+Eojs5xhgxrL47c
 C5sSSokT5WcH3weIXqacAuzo+omL6XwGNyvWnCeO8akoHlCgHTsAjF1AYzNXTU89T0+uWK
 d5HHdKpZAM1//B1YhM4HCeXXxkZwpiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-M9pNCqIUPeiLbs_w2GEBHg-1; Fri, 30 Oct 2020 16:17:53 -0400
X-MC-Unique: M9pNCqIUPeiLbs_w2GEBHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBE5510066FD
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 20:17:52 +0000 (UTC)
Received: from [10.3.113.218] (ovpn-113-218.phx2.redhat.com [10.3.113.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 961E11002397
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 20:17:52 +0000 (UTC)
Subject: Re: [PULL 00/12] NBD patches for 2020-10-27 soft-freeze
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20201027215914.619460-1-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d3deb484-4668-8215-7918-9d93eac1430a@redhat.com>
Date: Fri, 30 Oct 2020 15:17:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027215914.619460-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 4:59 PM, Eric Blake wrote:
> The following changes since commit 725ca3313a5b9cbef89eaa1c728567684f37990a:
> 
>   Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-20201026' into staging (2020-10-27 14:29:52 +0000)
> 
> are available in the Git repository at:
> 
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-10-27
> 
> for you to fetch changes up to a1487599cc3270ea0d435e8965ee2d6efc8f8a1a:
> 
>   nbd: Add 'qemu-nbd -A' to expose allocation depth (2020-10-27 16:46:21 -0500)
> 
> ----------------------------------------------------------------
> nbd patches for 2020-10-27
> 
> - Tweak the new block-export-add QMP command
> - Allow multiple -B options for qemu-nbd
> - Add qemu:allocation-depth metadata context as qemu-nbd -A
> - Improve iotest use of NBD
> 
> ----------------------------------------------------------------
> Eric Blake (10):
>       block: Simplify QAPI_LIST_ADD
>       qapi: Add QAPI_LIST_PREPEND() macro
>       nbd: Utilize QAPI_CLONE for type conversion
>       nbd: Update qapi to support exporting multiple bitmaps
>       nbd: Simplify qemu bitmap context name
>       nbd: Refactor counting of metadata contexts
>       nbd: Allow export of multiple bitmaps for one device
>       block: Return depth level during bdrv_is_allocated_above

Semantic conflict with 46cd1e8a that landed in the meantime; I'll post a
v2 pull request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


