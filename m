Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B9C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D03320820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZAIZuGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D03320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0fp-0006zD-PM
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj0cv-0002pf-1m
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:18:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25676
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj0cs-0006Dp-VP
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591795118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fjvibfpYl0DByW4nbgX6jNyorU03kRmHFCfX1t45I0=;
 b=NZAIZuGgzSp08YDdJ1yVnPGqWfA19N8wt69gHkrAejHalVHvXtTEhamJIpk5i6uOmqNE1w
 jwreBbooW0xq4LxwbXkDhAG8VGsdEYc/mFjZPMYtSchWVn7sqf8aDiG/mzoMCFBmGzFcQf
 1gCUmwT3GdpxEY8gTxMnwLzpg1YQ2qg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-Ejw63EgRO6yWEUerfaCKfA-1; Wed, 10 Jun 2020 09:18:30 -0400
X-MC-Unique: Ejw63EgRO6yWEUerfaCKfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10F4C19200C9
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:18:30 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1F8F7BA10
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:18:29 +0000 (UTC)
Subject: Re: [PULL 0/3] NBD patches through 2020-06-09
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200610011713.3687895-1-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0b58576a-593b-68ec-df80-26ad7dec4d42@redhat.com>
Date: Wed, 10 Jun 2020 08:18:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610011713.3687895-1-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/9/20 8:17 PM, Eric Blake wrote:
> The following changes since commit 31d321c2b3574dcc74e9f6411af06bca6b5d10f4:
> 
>    Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sparc-next-20200609' into staging (2020-06-09 17:29:47 +0100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-06-09
> 
> for you to fetch changes up to 2886df0c75c1c5f6aed054c54f4ad48aeee04bfd:
> 
>    block: Call attention to truncation of long NBD exports (2020-06-09 17:05:50 -0500)
> 
> ----------------------------------------------------------------
> NBD patches for 2020-06-09
> 
> - fix iotest 194 race
> - fix CVE-2020-10761: server DoS from assertion on long NBD error messages
> 
> ----------------------------------------------------------------
> Eric Blake (2):
>        nbd/server: Avoid long error message assertions CVE-2020-10761

Vladimir raised a potential thread-safety issue in this patch. As it is 
intended to fix a CVE, let's hold off on this pull request, and I'll 
send a v2 once I have better review.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


