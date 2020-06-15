Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A28C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAB420679
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy/sf7F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAB420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkntr-0004CF-DW
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 08:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkntE-0003lF-1h
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:07:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23978
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkntC-0006tX-E4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592222817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=UH/p8yBYE/X56qEKO3RuO5tDS7kqivHfm8tQEjKwLLM=;
 b=Qy/sf7F4dPFZc23gdblQbVeF9kth7yf7s6tXLjOvrhim/FIo+tKWDpZtGjQya46X4Jo3E0
 L8fvvoqz95pDEkgtWKztHFDMJjQw+DQfGdf/xsAeCGtv4rcDSi+UV6fW4DGTPTVjarsIee
 jiybvjY+BP4MWQubATsWORR/smIcP1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-pYCQT_kaPAOiUzcetN6btQ-1; Mon, 15 Jun 2020 08:06:55 -0400
X-MC-Unique: pYCQT_kaPAOiUzcetN6btQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D431C835B50
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:06:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-111.ams2.redhat.com [10.36.112.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3782E10013D6;
 Mon, 15 Jun 2020 12:06:54 +0000 (UTC)
Subject: Re: [PATCH v3 0/2] net: Drop legacy "name" from -net and remove
 NetLegacy
From: Thomas Huth <thuth@redhat.com>
To: Jason Wang <jasowang@redhat.com>
References: <20200518180103.32484-1-thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ccb94bbf-62f8-a15c-c7ba-5d2da724757f@redhat.com>
Date: Mon, 15 Jun 2020 14:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200518180103.32484-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/05/2020 20.01, Thomas Huth wrote:
> Since commit b4983c570c7a ("net: Remove deprecated [hub_id name] tuple of
> 'hostfwd_add' / 'hostfwd_remove'"), the "name" parameter is not used
> internally anymore. And it's been marked as deprecated since QEMU v3.1,
> so it is time to remove the "name" parameter from -net now. Once this
> has been done, we can also drop the obsolete NetLegacy structure since
> there is no major difference between Netdev and NetLegacy anymore.
> 
> v3:
>  - Do not make "id" in Netdev optional, but rather assign a temporary
>    "id" for -net before we call the options visitor function.
>  - Changed some "void *" to "Netdev *" now
> 
> v2:
>  - Rebased to master (use the deprecated.rst instead of qemu-deprecated.texi)
> 
> Thomas Huth (2):
>   net: Drop the legacy "name" parameter from the -net option
>   net: Drop the NetLegacy structure, always use Netdev instead

Ping!

Jason, do you think these patches are OK now, and if so, could you
please queue them for your next net pull request?

 Thanks,
  Thomas


