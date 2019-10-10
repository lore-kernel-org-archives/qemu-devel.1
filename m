Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B6C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4019E2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4019E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXsQ-0002Ru-Rt
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iIXfj-00012H-Ab
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iIXfh-0002Mp-Vz
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:35:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iIXfh-0002LK-NQ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:35:57 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA6149B29D
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 12:35:56 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id f2so4611208pfk.13
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 05:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WuGSboqXoL5Tq+QFCSc+M/OQGjhc/D2wSkJ1wpJc8es=;
 b=D/Vmx3qsSLFifrTp2Kb6FXpJeq0CG8sVgVqKOc3gdIjhrINECMH3qMGgO+50yxK+Af
 xUdPQl/65oYIyGvtu1NhgQ0Y2u0ryjDivSHqOw8apeYq7rZgT4GbY5AXUYx0ybkmLeia
 WHpcMY1I50r/J0qdSSDqNtBxIfoxmcC8yLNugrXS6rm4Cnl8kM/nMrqqg8/1n04WquZD
 rz73ftD3aH0wKqicsmqMdxWuHcTBUnv+o0kAoYfQsDZdsJ1HJTYONplLwInaWsxZAUJL
 x2R5etcHbI7zqGBL6YfIGHUizXcASXHT8zBj36CswviT185AzodQTUaakN1Lh9APgXy4
 MMLw==
X-Gm-Message-State: APjAAAWISXYI+5Cnm7czP4Edi6Fx+vwaV6b/UhYPbruO/X8bxfEYwHaZ
 KlmYookSUV074VvPagPQpAMkxEXAR9ecvU48fRxs1Db72TFH3Cf7vs1irQvjFR5pl1VTpLEdV76
 IN5eKxXbHBJlqDyg=
X-Received: by 2002:a62:5bc1:: with SMTP id p184mr9931147pfb.180.1570710956327; 
 Thu, 10 Oct 2019 05:35:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxU21Bd4HrdmKzbaK2lLQ5jz3MyzQvFbbAMaSDhQMo1RqhTW6tGGxPFPO/W5YdwSPY0ZkqsVA==
X-Received: by 2002:a62:5bc1:: with SMTP id p184mr9931126pfb.180.1570710956037; 
 Thu, 10 Oct 2019 05:35:56 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v8sm17149358pje.6.2019.10.10.05.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 05:35:55 -0700 (PDT)
Date: Thu, 10 Oct 2019 20:35:44 +0800
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3] migration: Support gtree migration
Message-ID: <20191010123544.GH18958@xz-x1>
References: <20191004112025.28868-1-eric.auger@redhat.com>
 <20191009062852.GB1039@xz-x1>
 <27d37e80-31d8-006a-b2a8-c61c5129c7c4@redhat.com>
 <20191010113541.GG18958@xz-x1>
 <c6f0142b-f325-a12c-433d-b77387c0a8a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6f0142b-f325-a12c-433d-b77387c0a8a9@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 10, 2019 at 02:11:46PM +0200, Auger Eric wrote:
> >>> Also, should we avoid using UINT in all cases?  But of course if we
> >>> start to use VMSTATE_UINT32_V then we don't have this issue.
> >> Depending on the clarification of above point, maybe I can rename
> >> VMSTATE_GTREE_DIRECT_KEY_V into VMSTATE_GTREE_DIRECT_UINT_KEY_V
> >>
> >> direct keys seem to be more common for hash tables actually.
> >> https://developer.gnome.org/glib/stable/glib-Hash-Tables.html#g-hash-table-new-full
> >>
> >> There are stand conversion macros to/from int, uint, size
> >> https://developer.gnome.org/glib/stable/glib-Type-Conversion-Macros.html
> > 
> > Yeh it's fine to use direct keys.  Though my question was more about
> > "unsigned int" - here when we put, we cast a pointer into unsigned
> > int, which can be 2/4 bytes, IIUC.  I'm thinking whether at least we
> > should use direct cast (e.g., (uint32_t)ptr) to replace
> > GPOINTER_TO_UINT() to make sure it's 4 bytes.  Futher, maybe we should
> > start with uint64_t here in the migration stream, otherwise we should
> > probably drop the high 32 bits if we migrate a gtree whose key is 64
> > bits long (and since we're working with migration we won't be able to
> > change that in the future for compatibility reasons...).
> > 
> > Summary:
> > 
> > Maybe we can replace:
> > 
> >     qemu_put_be32(f, GPOINTER_TO_UINT(key)); /* direct key */
> > 
> > To:
> > 
> >     qemu_put_be64(f, (uint64_t)key); /* direct key */
> > 
> > And apply similar thing to get() side?
> 
> This was my first idea as well but I got stuck with a mingw compilation
> issues if I remember correctly, trying to cast pointers to a wrong sized
> uint. This got removed by using the GPOINTER_TO_UINT conversion functions.

#define GPOINTER_TO_UINT(p) ((guint) (gulong) (p))

Could "(uint64_t)(uintptr_t)pointer" do the work?

Thanks,

-- 
Peter Xu

