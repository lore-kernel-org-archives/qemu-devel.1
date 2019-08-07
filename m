Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC19C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE9A20665
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE9A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQFa-0004J8-NI
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33114)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hvQEz-0003gd-O1
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hvQEy-0007y6-JU
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:00:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hvQEy-0007vP-C1
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:00:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so92224684wrl.7
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 11:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RnNcTkcEY3ZbfGxsdEEUpb9QGclJr+HC6jfSpFEWpCc=;
 b=qd7h4ZCKbyEp1DoA52rfq5IF4m390jx9dgt4OD5c948TO6sYyYKROXSCzPeZGxubWo
 rEiO8MWxhZRll/cVAo5ZmUYKKM99bHwWzGKjQF2VnhDbxNlyVytqOCcUx/eAg+Y9lIQ9
 3v2vP2yL+VYi5vTG/JnrIAZBVJlgRA6mGlTiyfzErOwL9Cvvpyu/ScqhanPCctZX1gs9
 Puql+Ux69W3vhWAgSnMr+KopH7b+oW23KMbEdqojtBiyrVqRzhobqHBWK+r6tlCTSIuG
 oNbYM7UB+03XPgfT/O6Er9H9XaJLrC1TeeThEZwey9MjwccnwC/vAPbS4GI28xsCdb+8
 hnKw==
X-Gm-Message-State: APjAAAUJ/7GeqqZ/RsCwsDeqCiJ52gE4xx5tOSeZIpsto8MNz4NphG9g
 rZqkt0CfL2wIGkp9ykWscgU79A==
X-Google-Smtp-Source: APXvYqyYoV6gvukGjStjYXXYOxG2iT1OUTlYjsb5W/KdyagD9b54ohMavaSsDHFf998uWCLRMeYzRA==
X-Received: by 2002:adf:8bd1:: with SMTP id w17mr12968197wra.50.1565200846958; 
 Wed, 07 Aug 2019 11:00:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id a19sm6155981wra.2.2019.08.07.11.00.42
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 11:00:46 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, tony.nguyen@bt.com,
 qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
 <1565166794966.57397@bt.com>
 <27c692bf-45af-afbe-27ba-1e8f7f936121@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <528a22e6-25a6-30c2-44e2-82df90bfa2da@redhat.com>
Date: Wed, 7 Aug 2019 20:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <27c692bf-45af-afbe-27ba-1e8f7f936121@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v6 20/26] memory: Access MemoryRegion with
 endianness
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, imammedo@redhat.com, sagark@eecs.berkeley.edu,
 david@redhat.com, jasowang@redhat.com, palmer@sifive.com,
 mark.cave-ayland@ilande.co.uk, laurent@vivier.eu, keith.busch@intel.com,
 jcmvbkbc@gmail.com, frederic.konrad@adacore.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, pburton@wavecomp.com,
 marex@denx.de, robh@kernel.org, hare@suse.com, sstabellini@kernel.org,
 berto@igalia.com, proljc@gmail.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, jslaby@suse.cz, deller@gmx.de, mst@redhat.com,
 magnus.damm@gmail.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 mreitz@redhat.com, hpoussin@reactos.org, joel@jms.id.au,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, rth@twiddle.net,
 philmd@redhat.com, green@moxielogic.com, atar4qemu@gmail.com,
 antonynpavlov@gmail.com, jiri@resnulli.us, ehabkost@redhat.com,
 minyard@acm.org, sw@weilnetz.de, alistair@alistair23.me, chouteau@adacore.com,
 b.galvani@gmail.com, eric.auger@redhat.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, yuval.shaia@oracle.com,
 stefanha@redhat.com, marcandre.lureau@redhat.com, shorne@gmail.com,
 sundeep.lkml@gmail.com, jsnow@redhat.com, david@gibson.dropbear.id.au,
 kwolf@redhat.com, crwulff@gmail.com, qemu-riscv@nongnu.org,
 xiaoguangrong.eric@gmail.com, i.mitsyanko@gmail.com, lersek@redhat.com,
 cohuck@redhat.com, alex.williamson@redhat.com, Andrew.Baumann@microsoft.com,
 jcd@tribudubois.net, andrew@aj.id.au, michael@walle.cc,
 paul.durrant@citrix.com, qemu-ppc@nongnu.org, huth@tuxfamily.org,
 amarkovic@wavecomp.com, kbastian@mail.uni-paderborn.de, jan.kiszka@web.de,
 stefanb@linux.ibm.com, andrew.smirnov@gmail.com, aurelien@aurel32.net,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/19 19:49, Richard Henderson wrote:
> On 8/7/19 1:33 AM, tony.nguyen@bt.com wrote:
>> @@ -551,6 +551,7 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, hwaddr addr,
>>          /* As length is under guest control, handle illegal values. */
>>          return;
>>      }
>> +    /* FIXME: memory_region_dispatch_write ignores MO_BSWAP.  */
>>      memory_region_dispatch_write(mr, addr, val, size_memop(len),
>>                                   MEMTXATTRS_UNSPECIFIED);
>>  }
> 
> Here is an example of where Paolo is quite right -- you cannot simply add MO_TE
> via size_memop().  In patch 22 we see
> 
>> @@ -542,16 +542,15 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, hwaddr addr,
>>          val = pci_get_byte(buf);
>>          break;
>>      case 2:
>> -        val = cpu_to_le16(pci_get_word(buf));
>> +        val = pci_get_word(buf);
>>          break;
>>      case 4:
>> -        val = cpu_to_le32(pci_get_long(buf));
>> +        val = pci_get_long(buf);
>>          break;
>>      default:
>>          /* As length is under guest control, handle illegal values. */
>>          return;
>>      }
>> -    /* FIXME: memory_region_dispatch_write ignores MO_BSWAP.  */
>>      memory_region_dispatch_write(mr, addr, val, size_memop(len),
>>                                   MEMTXATTRS_UNSPECIFIED);
> 
> This is a little-endian store -- MO_LE not MO_TE.

Or leave the switch statement aside and request host endianness.  Either
is fine.

Paolo

