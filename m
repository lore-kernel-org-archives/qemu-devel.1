Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51616C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B951B20792
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTi3LPTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B951B20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2f1S-0000gt-MJ
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 14:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2f0j-00009N-II
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:16:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2f0h-0002Oq-Nt
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596478590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJRcaZEa8NCJhD4OYCANZ9DMXc4BusYrGpZyQgwBSPE=;
 b=MTi3LPTHEWptmsEswbtdG6/tKPnUp7pwGXxYjUUkjF35TBZeVn9cfUFkuQpNaBgk4CRL6E
 6+w0PU8GLebIRTU2og5gQevS17qV45gHykDfaXxg3tF7BKBgOd06M/Fx9MxbYRt/mwQ3ce
 bGvUiUnSe7/Mu/7QJzwMvsxC0O/WAdo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-XObp4MI4ONye0iGnLba6Ew-1; Mon, 03 Aug 2020 14:16:28 -0400
X-MC-Unique: XObp4MI4ONye0iGnLba6Ew-1
Received: by mail-wr1-f69.google.com with SMTP id w7so9579737wre.11
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 11:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eJRcaZEa8NCJhD4OYCANZ9DMXc4BusYrGpZyQgwBSPE=;
 b=oGgwiPURsmTCwPSpFPuRR0RKI2SpztsDQvWI2nmHNIS8Dd4azTfQH25MdL7dS83+IU
 8QVR+JoXKYrRV3CzIGI5n4JCMr6EbcfOSPqwbbwAYAeK8l8hUR4IYVb9voVp+l2f9uHf
 tKrO24rrHfx3SWeRyScplSx3Poo9vM1Z+taq7aZpwu4AGUp/VA7pP6fct/lhzmf4Z1oQ
 az8WKDtLPrIVE+1ieLElpTZzlpKsRCXcdhRBaHwb7vvenyVan13OJqBnxuJSwtnCTyr2
 zlU1D4FtfWnfFEp1R/4WfZEUIxdjcd4NpPcgV+8dSprXldrULMZn2VUAxwOujwl3Uu0Y
 MFJA==
X-Gm-Message-State: AOAM531YlgBkurmo0sputvhKCO/B2VdRQwN0c9w3HuLcRikIt+yu1gSO
 aJSaqLuwmdu4BrgV7KjLBz2Q8fzTzLRGQZ/IptoaY0oY1XbVjvlr96SWaSIWiuGZ4hg0yjrT2vh
 dzPfhvR9SZh7LJKI=
X-Received: by 2002:a1c:4602:: with SMTP id t2mr417215wma.33.1596478584639;
 Mon, 03 Aug 2020 11:16:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvNhz6rW0up0pJGS/Itn2ZI5yeigl6UujDpezh3O80fGdN20FpStMuFshD/6u0nFBSyAAL3g==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr417184wma.33.1596478584292;
 Mon, 03 Aug 2020 11:16:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id q5sm25447354wrp.60.2020.08.03.11.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 11:16:23 -0700 (PDT)
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
 <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
 <17a92222-2627-4961-b57e-1f1f5c86e14a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e186e3b5-4aef-42c0-6957-2e5ae430686c@redhat.com>
Date: Mon, 3 Aug 2020 20:16:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <17a92222-2627-4961-b57e-1f1f5c86e14a@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/08/20 20:10, John Snow wrote:
> Heresy:
> 
> Docstrings could become part of the data format so they can be parsed,
> analyzed and validated. Parsers largely treat comments like non-semantic
> information and discard it. Round-trip parsers that preserve comments in
> any language are extremely rare.
> 
> If the docstrings are relevant to the generator and aren't discardable,
> they should be fully-fledged data members.
> 
> In a prototype I had for a YAML format, I just promoted docstrings
> directly to fields, so I could allow clients to query help text for
> individual commands.

This would be actually a good idea, but somebody has to write the code.
 Each field's docstring should be attached to the field, however---no
parsing needed only looking at the tree.  Take a look at what Nir posted:

> Here is the patch adding schema convertor from qemu "json" format to
> standard yaml:
> https://github.com/oVirt/vdsm/commit/e57b69e72987c0929b20306c454835b52b5eb7ee
> 
> The current version of the new yaml based schema:
> https://github.com/oVirt/vdsm/blob/master/lib/vdsm/api/vdsm-api.yml


    VmDiskDevice: &VmDiskDevice
        added: '3.1'
        description: Properties of a VM disk device.
        name: VmDiskDevice
        properties:
        -   description: Indicates if writes are prohibited for the
                device
            name: readonly
            type: boolean

        -   description: The size of the disk (in bytes)
            name: apparentsize
            type: uint

etc.

Paolo


