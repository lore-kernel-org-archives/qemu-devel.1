Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6CAC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 06:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9F020757
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 06:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGsUktSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9F020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPgjf-0002bm-No
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 02:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPgia-00024T-Se
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 02:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPgiY-0004YU-GF
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 02:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601966697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UXwYxpZ77ql5F/zaF5RK2XtY7ZjHQJDtRuEqtGY/boQ=;
 b=SGsUktSs7tTtL6HEf14dR147E2yl2YUv5wsEiRkG8AXSqZvkF2cuq4gYMG4g4w5KJsf3tc
 5T0vGzu+oOIH8fs6snyGgk5CyJfX9JoLaRajgF8DZxpZfCNy7FMzfd1J/yWGHgK2t5TaJa
 wirvMJZkYfcDNQSoT80rSY9lRhhXCHE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-KeuOYupINdm6YOpQgEgY9w-1; Tue, 06 Oct 2020 02:44:55 -0400
X-MC-Unique: KeuOYupINdm6YOpQgEgY9w-1
Received: by mail-wr1-f71.google.com with SMTP id b6so222382wrn.17
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 23:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UXwYxpZ77ql5F/zaF5RK2XtY7ZjHQJDtRuEqtGY/boQ=;
 b=pd2rp90Am/HDssSAwQdIBbykTO9TKQmSSf6wt4ygqfNp3knCNyJ/ikah17wZfaM0M0
 VyFExuc70WfsxvsT/13qbFROXM86LLZwggQD9QWh3MAVX4xqoEh7pIjK+KIRlw5jiCn6
 2kbo8I2mF+udzGUSy2AjIxM59K4Y6ook9KW4lLYDpA9nxnbnkG9eGbKla8Y6+TSWWINX
 Y0mu450z9DbHculGlGcEdcNnjlUPwjEE6nZ1mfEGRGu72swSvXm/i41AAON4P7V6n+/6
 M2tiwdSk884Lj3XTLQgqriM+FcPionNsMjCx9qiU2mpIm4vdDWgl8rLbMdy+/k90KY2g
 HEWw==
X-Gm-Message-State: AOAM530HWzSxlzwPuLyt91Oq0BJBBES6lAJXFpamBmD0viMELl7Q/T/2
 Px2cJY11OB/GDI0rw66eWGIgqb3IZp6VX7uBihZ5nFegnaLLmQFryUtgzN4eTd+ShbyEvvHfmVe
 eBANJDpt0F3kzQFA=
X-Received: by 2002:a1c:9d90:: with SMTP id g138mr3008370wme.5.1601966694491; 
 Mon, 05 Oct 2020 23:44:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7oChqUhBRLrWT4SznaLPM2ElwPZCzHj37GrxpgapR7J9CXydG7NjvxgBt1L1bjZ95f3QRrw==
X-Received: by 2002:a1c:9d90:: with SMTP id g138mr3008345wme.5.1601966694227; 
 Mon, 05 Oct 2020 23:44:54 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id m10sm2715090wmc.9.2020.10.05.23.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 23:44:53 -0700 (PDT)
Date: Tue, 6 Oct 2020 02:44:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH v3 0/7] Use ACPI PCI hot-plug for Q35
Message-ID: <20201006023922-mutt-send-email-mst@kernel.org>
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924050236-mutt-send-email-mst@kernel.org>
 <CAMDeoFU_ZO7UxQsz-tvA6WsFm2qK755W5guGoVHfVs55Gb7aUg@mail.gmail.com>
 <20201001073823-mutt-send-email-mst@kernel.org>
 <CAMDeoFXCApc0zqeXc9AO8smJgLk4EvZA7XdL-dsN9HZTJa4MDA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMDeoFXCApc0zqeXc9AO8smJgLk4EvZA7XdL-dsN9HZTJa4MDA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 01, 2020 at 05:54:39PM +0200, Julia Suvorova wrote:
> > > Right now I disable native if there is acpihp anywhere, but even if
> > > you enable it for hotplugged devices, native hot-plug will not work.
> >
> > So that's a minor regression in functionality, right?
> > Why is that the case? Because you disable it in ACPI?
> > What if we don't?
> 
> I meant that I disable slot hotplug capabilities, nothing in ACPI
> prevents native from working. Actually, I don't see if there's any
> regression at all. Configurations like hot-plugging downstream port or
> switch to another downstream port haven't worked before, and they
> don't work now. I can enable native for hotplugged bridges, but that
> doesn't make sense, because you won't be able to hot-plug anything to
> it.


You can do the following hack right now:
1- add an upstream port as function 1
2- add a downstream port behind it
3- add some other device (e.g. another upstream port?) as function 0

As this point both ports should be detected.

Going forward we can consider support for adding ports in a hidden state
(not visible to guest) so one won't need an extra function.

> It's not an issue of ACPI, it's PCIe behaviour. Also, native-acpi
> combination may seem bizarre to os

Maybe, maybe not ...
Worth testing whether this works with existing guests.

> (slot enumeration is independent,
> that's why I suggested disabling pcie slot flags).

Yes that part makes sense imho.

-- 
MST


