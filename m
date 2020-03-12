Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1721C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C109E20650
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIAqUMME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C109E20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCHKH-0002V7-Ri
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 02:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCHJk-00026I-PC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCHJj-0001gd-Ia
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:27:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43338
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCHJj-0001gZ-Ez
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583994458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vW79lUS0h1V7Eyblq4bb+3SFkOltmth3ON+GRbz419c=;
 b=UIAqUMMEy+EyrRoo3RSbHTWt8ItzoD6AmMSGDNkkkpt69364btE89fYQ/U6p+r+dOhVWps
 E5UJIECOJw1ESflkIxtxY3EiT5UNlJhlIIOPrRnGVBrFlSONPcae39PPRZFQe9FEXvK5Q7
 oMGWbsR0DpKVHXGC2KkrOAQ/6XK8bNQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-04u9vXEMMuOL3f9TgoybDA-1; Thu, 12 Mar 2020 02:27:37 -0400
X-MC-Unique: 04u9vXEMMuOL3f9TgoybDA-1
Received: by mail-qk1-f198.google.com with SMTP id k194so3174268qke.10
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 23:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yf15mK3j0ve3Ws3qlHwRST8JSAglK1FKhDOoy3AIEA8=;
 b=NdzHUmxr9YsiZpc9oAfWtLQuic04sgtQY5D/SEylL8GojaW8vc4+wF12xjMUvzKMWr
 qc3DcBmSubvhMcPbDMAZ6OdWae2F0cjnz45hI7yS6dVYPsJ2kmzqVe22sYHtQ2spsPRQ
 8Ph0pR4OnnH4InKPbv/mPLVH+DNJVHBTZja5uUMI0CxCOHBOvpHlhuzliJ7ZWusx46Ct
 95ZZUhaza72PHvcU6bRLqZkvp4Z+cTl3mEui9W5pSP2XGplxqZ54wlUW2ItamXEMKB4Z
 j7/syjJRxH/ARqzy7edt+TpMty71vaC/9k6k8IU4xa40zwjLp63/6qkF8fC0/jf17lcD
 fZPA==
X-Gm-Message-State: ANhLgQ365s9Bj/n+Vbdql+wC+ciMuTxf//3Peohdw7MZy6oKRb5eXaq+
 /8hA4f+WIyNCujd3rMlHXE0KCghM6TMjC8yO2mDhYYTwVS4+6Gylxa1Lwwz9W/h/TmQ0eXrkT58
 hBHwAwggsgSYdEbY=
X-Received: by 2002:a0c:ecc3:: with SMTP id o3mr6139510qvq.163.1583994456496; 
 Wed, 11 Mar 2020 23:27:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvNTpkCjt4y/GnMaV2A4H5jlVn1SnHz0XFSH1tgWwUKhyaMurNM3ONJxrLkNWeCP5PVmXIOQg==
X-Received: by 2002:a0c:ecc3:: with SMTP id o3mr6139497qvq.163.1583994456263; 
 Wed, 11 Mar 2020 23:27:36 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id a141sm27093323qkb.50.2020.03.11.23.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 23:27:35 -0700 (PDT)
Date: Thu, 12 Mar 2020 02:27:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200312021332-mutt-send-email-mst@kernel.org>
References: <158395315920.8804.12475968769225149761@39012742ff91>
 <ebb59967-ebd3-374a-a2a6-1f374e4768ad@oracle.com>
 <20200311162321-mutt-send-email-mst@kernel.org>
 <f746828c-0a15-2613-a6bf-300750be1be5@oracle.com>
MIME-Version: 1.0
In-Reply-To: <f746828c-0a15-2613-a6bf-300750be1be5@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 elad.gabay@oracle.com, imammedo@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 03:31:49AM +0200, Liran Alon wrote:
>=20
> On 11/03/2020 22:24, Michael S. Tsirkin wrote:
> > Notice the process as documented in ./tests/qtest/bios-tables-test.c
> >=20
> Thanks for explicitly pointing me to that process.
>=20
> I have followed the process described there (Both steps 1-3 and steps 4-7=
).
> On step (6), I have noted that many existing ACPI tables don't have expec=
ted
> binaries for all the execution-matrix.
> E.g. tests/data/acpi/pc/APIC.{bridge, ipmikcs, memhp, numamem} are all
> missing.
> Similar missing files exists for FACP, FACS, HPET and MCFG.
>=20
> I should add for WAET the expected binaries for all the execution-matrix
> right?
> Is it just an existing issue that for the existing tables some of the
> expected binaries are missing? But the tests seems to pass.
> Can you clarify this for me?
>=20
> Thanks,
> -Liran

It's because of this (which we should probably rewrite as a loop):

try_again:
        aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machin=
e,
                                   sdt->aml, ext);
        if (getenv("V")) {
            fprintf(stderr, "Looking for expected file '%s'\n", aml_file);
        }
        if (g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
            exp_sdt.aml_file =3D aml_file;
        } else if (*ext !=3D '\0') {
            /* try fallback to generic (extension less) expected file */
            ext =3D "";
            g_free(aml_file);
            goto try_again;
        }

if WAET is always added, then a single WAET will be enough for you.

--=20
MST


