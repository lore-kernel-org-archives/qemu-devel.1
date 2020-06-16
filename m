Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E60820776
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/a+thdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E60820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlANn-0000rW-Nd
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jlAMd-0000AB-4X
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:06:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jlAMb-00018m-Fr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592309208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfTCpQF9W4sCdZ61TrxmHwYeLq4dXGY+QB87Bb/+irg=;
 b=c/a+thdqccrLM71l70fVxzDnkM49OzyXDePe6EWWHN181rlq/66q3uBLcC0PAe528EhVrk
 DvALKIX0d7rRq/QjzdXwg7viGCEY3c8dPz+J9XBvn4317hLAbuiZkG7Cy+7CgWTItj5cSS
 jCpVM45qCKbdS0S6YUPpaFJQZHv2Wak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-HkgJBQEMMuKYRPr-IHti0Q-1; Tue, 16 Jun 2020 08:06:46 -0400
X-MC-Unique: HkgJBQEMMuKYRPr-IHti0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F4BA2210C2;
 Tue, 16 Jun 2020 12:06:45 +0000 (UTC)
Received: from localhost (unknown [10.40.208.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D51B07FE82;
 Tue, 16 Jun 2020 12:06:21 +0000 (UTC)
Date: Tue, 16 Jun 2020 14:06:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v4 1/5] acpi: Convert build_tpm2() to build_append* API
Message-ID: <20200616140620.15246816@redhat.com>
In-Reply-To: <28121558-7a75-73da-6939-da0c0e776087@linux.ibm.com>
References: <20200611135917.18300-1-eric.auger@redhat.com>
 <20200611135917.18300-2-eric.auger@redhat.com>
 <28121558-7a75-73da-6939-da0c0e776087@linux.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, mst@redhat.com,
 philmd@redhat.com, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jun 2020 10:25:38 -0400
Stefan Berger <stefanb@linux.ibm.com> wrote:

> On 6/11/20 9:59 AM, Eric Auger wrote:
[...]
> > -    tpm2_ptr->log_area_minimum_length =
> > -        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
> > +    /* Platform Specific Parameters */
> > +    g_array_append_vals(table_data, &start_method_params,
> > +                        ARRAY_SIZE(start_method_params));
> >   
> > -    acpi_data_push(tcpalog, le32_to_cpu(tpm2_ptr->log_area_minimum_length));
> > +    /* Log Area Minimum Length */
> > +    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);  
> 
> Here you push data related to TPM2 table...
> 
> 
> > +
> > +    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);  
> 
> ... here you push log area memory ...
> 
> 
> >       bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
> >                                false);
> >   
> > -    /* log area start address to be filled by Guest linker */
> > +    log_addr_offset = table_data->len;
> > +    build_append_int_noprefix(table_data, 0, 8);  
> 
> 
> ... here you push TPM2 table related data again. Is this right or did we 
> just mess up the TPM 2 table?

it's 2 differnt blobs tcpalog and table_data

> 
> 
> > +    /* Log Area Start Address to be filled by Guest linker */
> >       bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> > -                                   log_addr_offset, log_addr_size,
> > +                                   log_addr_offset, 8,
> >                                      ACPI_BUILD_TPMLOG_FILE, 0);
> >       build_header(linker, table_data,
> > -                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
> > +                 tpm2_ptr, "TPM2", table_data->len - tpm2_start, 4, NULL, NULL);
> >   }
> >   
> >   #define HOLE_640K_START  (640 * KiB)  
> 
> 


