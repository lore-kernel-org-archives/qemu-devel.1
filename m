Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270C9C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 12:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB78218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 12:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB78218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAvuy-000075-3P
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 08:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iAvsB-0006Ji-Je
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iAvou-0005bx-Gh
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:46:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iAvou-0005al-9F
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:46:00 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4940387642
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 12:45:59 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id t11so1007254wrq.19
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 05:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F2hjPOW93W8+OdeJLvYCKKNrC6tn8HHEz3RxjVBWKrU=;
 b=sobT8/URssLiKtyFhzfl1L3ZDdj0kkPkc12K/7t/p79yjMCYlfWCxLLveNCZCF4nBo
 KKBL8ua6/vaMkLRV1isN8dnpInNerQBAlLFFmaEagalfJ/hf7tapaN3dyPDVopkYTUtM
 pbiFsdk+RjM/y7qAEr1LZZ4cGrrBBNgY2+JvRJBcsaY7+BkkfB+HgbtKIGaEB4qyh1LJ
 jVnevqzHcA3EmOlueKB+wn80BuMr74pGFnYn8x2gUQ+4UEZZPFTLD3kGTO0SQUBuWUWI
 9i69m50bkztjb1qS0ZZX/zCKLW2oiToi57g6U6QYW+bhh3npZCXaUPKPPo1fcMwXvWyc
 E/Ug==
X-Gm-Message-State: APjAAAUAZZwu1F3WIbIQpBmQgiSLykW1O1v9Pib4FTbtcqEKdKIDVwCP
 gv+hqT2o+Syt5iOxu9/UkQcwfozObdbAvFoSvVh/Uoi7a588ubTgEtWNOsQBFGIl4neD8u40anZ
 OkhD839O/4u4C4qA=
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr7586291wru.190.1568897157775; 
 Thu, 19 Sep 2019 05:45:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzOEc5HB38C0LwVKR4cN6MZAm9Nv6B2BnHiP8MWsEXtAj6QkhWustFkyo16Bmc0PidHA77c0g==
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr7586272wru.190.1568897157482; 
 Thu, 19 Sep 2019 05:45:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id r20sm12634514wrg.61.2019.09.19.05.45.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 05:45:56 -0700 (PDT)
To: Jason Wang <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <8302a4ae-1914-3046-b3b5-b3234d7dda02@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B1D1@SHSMSX104.ccr.corp.intel.com>
 <6d73572e-1e89-b04a-bdd6-98ac73798083@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B90C@SHSMSX104.ccr.corp.intel.com>
 <204219fa-ee72-ca60-52a4-fb4bbc887773@redhat.com>
 <20190919052819.GA18391@joy-OptiPlex-7040>
 <7b6d6343-33de-ebd7-9846-af54a45a82a2@redhat.com>
 <20190919061756.GB18391@joy-OptiPlex-7040>
 <e0efbdc0-aad9-0d17-ec68-36460865501f@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57DD2A@SHSMSX104.ccr.corp.intel.com>
 <1ec55b2e-6a59-f1df-0604-5b524da0f001@redhat.com>
 <00084b36-3281-7c8d-5057-427eaabfb174@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8fb74d6c-5449-bccb-deab-5300f2a50122@redhat.com>
Date: Thu, 19 Sep 2019 14:45:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <00084b36-3281-7c8d-5057-427eaabfb174@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
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
Cc: 'Alex Williamson' <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/19 14:39, Jason Wang wrote:
>> In general, userspace cannot assume that it's okay to sync just throug=
h
>> GPA1.=C2=A0 It must sync the host page if *either* GPA1 or GPA2 are ma=
rked
>> dirty.
>=20
> Maybe we need document this somewhere.

Well, it's implicit but it should be kind of obvious.  The dirty page
only tells you that the guest wrote to the GPA, HVAs are never mentioned
in the documentation.

Paolo

> Any other issue that still need to be covered consider userspace need t=
o
> sync both GPAs?
>=20
> Thanks
>=20


