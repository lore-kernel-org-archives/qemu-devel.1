Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8B4C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278F6206CA
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUrotRPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278F6206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlbU-0003si-BU
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kGlau-0003S6-TU
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kGlat-0005Xm-Bj
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599840490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bd6bz9LI0IKgzhS6ZsVrbR+6i++qVn7fzWV0dw+BrAk=;
 b=SUrotRPqq+ZSDXR7jwENaBnsNa+AJ7nvxFSb20yBRUbFcDOTww1wv5oIaoLEcNu4uPacMV
 GR1RCo7bcr2033GGOXWUzaglRcZ9OXWuBTOKmTdHPLfMQtMDaQE2bMBXQ/gI2RUKZurNnI
 f6y1cImw2hTRc8VDQH18oOgxHgxptyM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-p2x0pfRBOOuBVeIGOOhhGw-1; Fri, 11 Sep 2020 12:08:08 -0400
X-MC-Unique: p2x0pfRBOOuBVeIGOOhhGw-1
Received: by mail-wr1-f72.google.com with SMTP id l15so3663847wro.10
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Bd6bz9LI0IKgzhS6ZsVrbR+6i++qVn7fzWV0dw+BrAk=;
 b=KLrZ3SnqQ1ZGSFz6kRGeeY16A02Tr9vb42BYJB8olUmHjHxtPhHPlm7dLGeKaemhOQ
 CNDlOZrfUpa+2ok3546Mog9/ukB8Qkw1oHFAJMV/QVFRneV1pbJHhwN55QaxgTE7ZJ4y
 zax2aHJ4tHpIhmGCJ2asoUXvFUNLs5K4AcGF8wX0TaK5uY3JU8TqWWtF9XvgAPyf7j16
 n6SgNVQLahUCkrYHVDLEOfZ98ZguiafkR2ORi1JCm2boSfz1eFgkqOtWvNb8StoqN/dQ
 FALLf1sBBoR4yrMk6LV0vhF9DsfESFgxeR+30c+7/iS7mpyMyGtbUm3dTEbYGTM/76t+
 Wssw==
X-Gm-Message-State: AOAM530C+B2EkhgUfcKonTc2jKcbfQ96rvGJRh7wQo3LALUltRoZY/46
 l4MU2HhzAMxtydMx9hK8UI1nJj8aqa4yKE1efoRMD+j+K9DDTqtiVdmDkroE7KeCbgVRH8F3fru
 9Ll45xdcnT2Sr4Mo=
X-Received: by 2002:a5d:634d:: with SMTP id b13mr2864750wrw.324.1599840486968; 
 Fri, 11 Sep 2020 09:08:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyUE//OzP97TWPL/teljiqYMowZi6X3/AHPBBr3r9DD4P8N3xkHsWwtMShZV8RwKYg6I0Z5w==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr2864729wrw.324.1599840486823; 
 Fri, 11 Sep 2020 09:08:06 -0700 (PDT)
Received: from redhat.com ([176.230.64.162])
 by smtp.gmail.com with ESMTPSA id f14sm5454071wrv.72.2020.09.11.09.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 09:08:05 -0700 (PDT)
Date: Fri, 11 Sep 2020 12:08:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v1 0/3] unit tests for change 'do not add hotplug related
 amls for cold plugged bridges'
Message-ID: <20200911120548-mutt-send-email-mst@kernel.org>
References: <20200905103520.12626-1-ani@anisinha.ca>
MIME-Version: 1.0
In-Reply-To: <20200905103520.12626-1-ani@anisinha.ca>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>, jusual@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


I am not sure why, but the expected files did not match for me.

I dropped these for now:

tests/acpi: add a new ACPI table in order to test root pci hotplug on/off
tests/acpi: add a new unit test to test hotplug off/on feature on the root pci bus
tests/acpi: document addition of table DSDT.roothp for unit testing root pci hotplug on/off
tests/acpi: add newly added acpi DSDT table blob for pci bridge hotplug flag
tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support' bridge flag
tests/acpi: list added acpi table binary file for pci bridge hotplug test

I suspect you have another change in there.

Pls check and post a single series with all these tests.

-- 
MST


