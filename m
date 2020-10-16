Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE59C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564FB20866
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxrBOW1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564FB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTQYb-0004zA-WC
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 10:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kTQXj-0004Vf-Pq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 10:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kTQXg-0007Mt-La
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 10:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602857831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UOt0Z+vxe2aEtQ0+x3zw0Ae7UgO/EU6s85qlW696vPI=;
 b=gxrBOW1g8xYnt7DNYR/pj1x1IKav+evMVJyzaE4oTKk4d6fZBoWZeADGO+x3iOg52TgHqz
 IMQC8NKeznak25dBKh7LDn2DtteegePoDy/ZdBa0VgTUwmIxiPlbdfRegqge1dq/QukuC6
 xKQ4qi0pafHdUnd865j0E3TXr3qVMyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-2aJ-wcAzOw2FnDoTTCuSlw-1; Fri, 16 Oct 2020 10:17:07 -0400
X-MC-Unique: 2aJ-wcAzOw2FnDoTTCuSlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B265B1005E5C;
 Fri, 16 Oct 2020 14:17:06 +0000 (UTC)
Received: from kaapi (ovpn-112-57.phx2.redhat.com [10.3.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33FF75C1BD;
 Fri, 16 Oct 2020 14:17:03 +0000 (UTC)
Date: Fri, 16 Oct 2020 19:47:01 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: About 'qemu-security' mailing list
In-Reply-To: <nycvar.YSQ.7.78.906.2010012320290.830962@xnncv>
Message-ID: <nycvar.YSQ.7.78.906.2010161910530.1246156@xnncv>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv> <m2362z8dvx.fsf@oracle.com>
 <nycvar.YSQ.7.78.906.2010011502290.830962@xnncv> <m2mu166uyg.fsf@oracle.com>
 <nycvar.YSQ.7.78.906.2010012320290.830962@xnncv>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hello Darren, all

+-- On Thu, 1 Oct 2020, Darren Kenny wrote --+
| On Thursday, 2020-10-01 at 16:05:58 +0530, P J P wrote:
| > - A list member triaging such issue, would have to select their individual 
| >   keys for each reply.
| 
| Maybe, honestly not had to deal with it personally.

  "Ideally, encrypt all of your messages to their (possibly multiple) 
   recipients. This means that you need not only the list's public key, but 
   also keys for the reporter and for anyone else CC'ed. You may exercise your 
   best effort to obtain such keys (from keyservers, by asking in the thread in 
   plaintext without quoting any sensitive content, etc.), or failing that you 
   may fallback to plaintext, in which case you should refrain from quoting 
   (and adding) non-essential sensitive content. For example, if you merely 
   want the reporter to agree to or specify a public disclosure date, then you 
   may send a plaintext message back to them with this request and nothing else 
   (most importantly, do not quote their original report)."

  -> https://oss-security.openwall.org/wiki/mailing-lists/distros

* Found above text for encrypted email workflow to communicate with non-member
  reporters.


+-- On Thu, 1 Oct 2020, P J P wrote --+
| Encrypted list, open to receive non-encrypted reports seems okay. Will have 
| to check how to set it up and its workflow.

* I reached out to '@solardiz' to check if the back end scripts/tools which 
  power automatic encryption on '-distros' list are available as open source 
  tools.

  Unfortunately not.

* As his suggestions/inputs for a list, he said:

  >On Friday, 9 October, 2020, 12:15:37 am IST, Solar Designer wrote:
  >
  > my biggest concern is that issues discussed there or reproducers for them 
  > might stay unpublished for very long, and would be a lucrative target.
  > I think a more important than encryption property of the distros list is 
  > that we impose a maximum embargo time, and have requirements on 
  > publication of exploits too if those were provided.
  >

* So ie. we need to:

  1. Create/setup a regular non-encrypted 'qemu-security' list.

  2. Invite representatives from user/downstream communities to subscribe to 
     it.

  3. Collect & store their PGP public keys. Also create a key for the list.

  4. Write 'encrypt & email' automation tool(s) to provide encryption support.

  5. Document and publish above details and list workflow on a page.


...wdyt?


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


