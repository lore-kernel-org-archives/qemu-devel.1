Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BDAC4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA4C20888
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3zjr3Ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA4C20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQOA-0002U4-Lx
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 14:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKQGy-0004wN-1W
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKQGt-0003sl-6g
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600711838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUsB3RQT48gtASKJ+NMZv8M846xaFioGYobNqEAvZfk=;
 b=Q3zjr3ObIItgsM+e27c0WC+QczYPwSNgJkkB/AJQbWCUXQRoLXlnhGC1LBzDLsXnt6lLid
 kDvlR6+s5w0YSu22/HtoYILrBwNM7KquEg6wx0vuxRbeRR8QPQGafHKLDm4RdY6Mt03FXc
 6/wF4SVurCiJEDhmicHQBFl2KBc+L2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-EdZJR1DAO1OkYh0V82F8hg-1; Mon, 21 Sep 2020 14:10:36 -0400
X-MC-Unique: EdZJR1DAO1OkYh0V82F8hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC3BF18BA280;
 Mon, 21 Sep 2020 18:10:34 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-14.ams2.redhat.com [10.36.112.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB3E360C11;
 Mon, 21 Sep 2020 18:10:29 +0000 (UTC)
Subject: Re: [PATCH 4/7] shippable.yml: Remove the Debian9-based MinGW
 cross-compiler tests
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200921174320.46062-1-thuth@redhat.com>
 <20200921174320.46062-5-thuth@redhat.com>
 <20200921180735.GW1942072@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1a939758-99df-9f59-9fa9-4232f9b76425@redhat.com>
Date: Mon, 21 Sep 2020 20:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200921180735.GW1942072@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/2020 20.07, Daniel P. Berrangé wrote:
> On Mon, Sep 21, 2020 at 07:43:17PM +0200, Thomas Huth wrote:
>> We're not supporting Debian 9 anymore, and we are now testing
>> MinGW cross-compiler builds in the gitlab-CI, too, so we do not
>> really need these jobs in the shippable.yml anymore.
> 
> For that matter aren't all the other shippable entries obsolete
> now too since we added .gitlab-ci.d/crossbuilds.yml ?

Yes, they are covered by the gitlab-ci now, too.

> IOW, can we remove shippable entirely at this point ?

We likely could ... but I recently had a very quick chat with Alex in
IRC, and we agreed to keep them for a while until it's  clearer whether
we can continue with unlimited CI minutes in gitlab or not.

 Thomas


