Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D3BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A781D206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A781D206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BJt-0004J0-CF
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i1BHz-00031X-HL
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i1BHy-0004Nd-9D
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:15:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i1BHy-0004Mn-0e
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:15:42 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A4044FCD9
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 15:15:40 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id x12so4970999wrw.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 08:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vhujCZ9GOOcwNPhLV4QGT2g5fNBEHZTwX7L1j9gTUpg=;
 b=NOGpFOr7pHPTwcqY7zuOBhuALajfHvaVfl6acYU0hLhrNZVScmw/QpjZnv2uQJDBQ4
 0HE32tuS5PNLvhc8I1al2h7t3eFbrF1KSE/Xl+4lwiYF7VVjkRp7taGlf3nIEI/RLMxh
 BLkdJjNRgn3jS/1eqtVe9qodiy6pZssK1aTif3bBUDt3g0sv7YyYazrEJNfB6xzyKAjY
 P9F0y9bLlxrpRqPhQMDV49jfnvOA5dC7f/ErUQxyh2U6+P6B4B45rbLbz/sOOUaE6vZW
 ZmnWVQN3FnY/xAQGkY281qyO3/tjX9B6T/PP8C7daY9pmtB8nZ9B9+fVcyP4PgBWOo3R
 3s0A==
X-Gm-Message-State: APjAAAWeDsmdo6/66oSoHDYAfXnzHNBGj5gjg/oAbXVUxEJUo6dCtijW
 xRaQvmYJm+3DlZ18S7sXGWXusHeidP+gBqF6juCoBCQOneiqkKicB+ImsgPYr9cGX1Z/dQjsw5Y
 1d510aeQ6KQXnBKg=
X-Received: by 2002:a1c:20c3:: with SMTP id g186mr5813997wmg.15.1566573338933; 
 Fri, 23 Aug 2019 08:15:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYINjF41+Hk+XHcUpOSe2Ns0LgCSZbjRXwlBDaNpFpYP/aRGm5a773bocnOA2x93YIm3hIzw==
X-Received: by 2002:a1c:20c3:: with SMTP id g186mr5813973wmg.15.1566573338700; 
 Fri, 23 Aug 2019 08:15:38 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id o8sm6917339wma.1.2019.08.23.08.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2019 08:15:38 -0700 (PDT)
To: Samuel Thibault <samuel.thibault@gnu.org>, slirp@lists.freedesktop.org,
 Petr Matousek <pmatouse@redhat.com>, Vishnu Dev TJ <vishnudevtj@gmail.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>
References: <20190822144134.23521-1-philmd@redhat.com>
 <20190822144134.23521-2-philmd@redhat.com>
 <20190822183313.pptfwjsnrpdi6tfp@function>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <14216968-a066-6abf-1952-3cff3aa3eee3@redhat.com>
Date: Fri, 23 Aug 2019 17:15:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190822183313.pptfwjsnrpdi6tfp@function>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Slirp] [PATCH 1/2] Do not reassemble fragments
 pointing outside of the original payload
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/19 8:33 PM, Samuel Thibault wrote:
> Philippe Mathieu-Daud=C3=A9, le jeu. 22 ao=C3=BBt 2019 16:41:33 +0200, =
a ecrit:
>>   Later the newly calculated pointer q is converted into ip structure
>>   and values are modified, Due to the wrong calculation of the delta,
>>   ip will be pointing to incorrect location and ip_src and ip_dst can
>>   be used to write controlled data onto the calculated location. This
>>   may also crash qemu if the calculated ip is located in unmaped area.
>=20
> That does not seem to be related to this:

Indeed, I wonder if this is the same issue reported in the CVE.

>> Do not queue fragments pointing out of the original payload to avoid
>> to calculate the variable delta.
>=20
> I don't understand the relation with having to calculate delta.
>=20
>> diff --git a/src/ip_input.c b/src/ip_input.c
>> index 7364ce0..ee52085 100644
>> --- a/src/ip_input.c
>> +++ b/src/ip_input.c
>> @@ -304,6 +304,19 @@ static struct ip *ip_reass(Slirp *slirp, struct i=
p *ip, struct ipq *fp)
>>          ip_deq(q->ipf_prev);
>>      }
>> =20
>> +    /*
>> +     * If we received the first fragment, we know the original
>> +     * payload size.
>=20
> ? We only know the total payload size when receiving the last fragment
> (payload =3D offset*8 + size).
>=20
>> Verify fragments are within our payload.
>=20
> By construction of the protocol, fragments can only be within the
> payload, since it's the last fragment which provides the payload size.

I might have misunderstood the RFC, I'll read it again.

>> +    for (q =3D fp->frag_link.next; q !=3D (struct ipasfrag*)&fp->frag=
_link;
>> +            q =3D q->ipf_next) {
>> +        if (!q->ipf_off && q->ipf_len) {
>> +            if (ip->ip_off + ip->ip_len >=3D q->ipf_len) {
>> +                goto dropfrag;
>> +            }
>> +        }
>> +    }
>=20
> Fragments are kept in order, there is no need to go around the list to
> find the fragment with offset zero, if it is there it is the first one.

OK.

> Did you make your test with commit 126c04acbabd ("Fix heap overflow in
> ip_reass on big packet input") applied?

Yes, unfortunately it doesn't fix the issue.

Thanks,

Phil.

