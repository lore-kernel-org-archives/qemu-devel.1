Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1EBC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA7020652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA7020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54615 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL2Wn-0006fy-Qi
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 05:24:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hL2Gt-0001ve-NX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hL22d-0005BL-UI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:53:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hL22d-0005B7-MC; Mon, 29 Apr 2019 04:53:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEFF83092662;
	Mon, 29 Apr 2019 08:53:38 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6E35E6442C;
	Mon, 29 Apr 2019 08:53:34 +0000 (UTC)
Date: Mon, 29 Apr 2019 10:53:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190429105332.14434866.cohuck@redhat.com>
In-Reply-To: <7157e9b3-4432-32cc-9327-22e0d0124987@de.ibm.com>
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
	<20190426111003.21246-11-borntraeger@de.ibm.com>
	<71955bba-ef04-1677-b7f0-bb1675bad12a@redhat.com>
	<07252560-1eed-8fd5-ee94-6bcea6cf99bc@de.ibm.com>
	<10d43e6e-ee8c-cd65-e724-354e0f40c79f@redhat.com>
	<057d438c-2062-1aa7-887a-918f076911c5@de.ibm.com>
	<93f0ecac-47cc-c791-9e32-ad5743489bf3@redhat.com>
	<20190426145506.409b53cf.cohuck@redhat.com>
	<7157e9b3-4432-32cc-9327-22e0d0124987@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 29 Apr 2019 08:53:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 10/10] s390x/cpumodel: wire
 up 8561 and 8562 as gen15 machines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429085332.Ep5C9jZKwmAmKCjBBKqCcl_TsgmSC9O0h6RkDQ3R_dA@z>

On Mon, 29 Apr 2019 09:51:39 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 26.04.19 14:55, Cornelia Huck wrote:
> > On Fri, 26 Apr 2019 14:05:30 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 26.04.19 14:01, Christian Borntraeger wrote:  
> >>>
> >>>
> >>> On 26.04.19 13:52, David Hildenbrand wrote:    
> >>>> On 26.04.19 13:36, Christian Borntraeger wrote:    
> >>>>>
> >>>>>
> >>>>> On 26.04.19 13:32, David Hildenbrand wrote:    
> >>>>>> On 26.04.19 13:10, Christian Borntraeger wrote:    
> >>>>>>> 8561 and 8562 will be gen15 machines. There is no name yet, lets us use
> >>>>>>> the cpu id as base name. Later on we can provide aliases with the proper
> >>>>>>> name.
> >>>>>>>
> >>>>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>>>>>> ---
> >>>>>>>  target/s390x/cpu_models.c | 2 ++
> >>>>>>>  1 file changed, 2 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> >>>>>>> index d683635eb5..dd6415103f 100644
> >>>>>>> --- a/target/s390x/cpu_models.c
> >>>>>>> +++ b/target/s390x/cpu_models.c
> >>>>>>> @@ -83,6 +83,8 @@ static S390CPUDef s390_cpu_defs[] = {
> >>>>>>>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
> >>>>>>>      CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
> >>>>>>>      CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
> >>>>>>> +    CPUDEF_INIT(0x8561, 15, 1, 47, 0x08000000U, "8561", "IBM 8561 GA1"),
> >>>>>>> +    CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "8562", "IBM 8562 GA1"),
> >>>>>>>  };    
> >>>>>>
> >>>>>> Thinking out loud, I know that official names are not published yet.
> >>>>>> Looking at the recent history (z13, z14), my educated guess would be
> >>>>>> z15. I guess pretty much everybody would guess that.    
> >>>>>
> >>>>> Not sure about trademark aspects - especially if this really becomes z15. The smaller
> >>>>> machine has no real history (ZR1 vs. s vs BC). So I think I would rather have a correct
> >>>>> number than a partially correct name.    
> >>>>
> >>>> We could also use "gen15a" and "gen15b", still better to get than magic
> >>>> numbers. (yeah well, they are not magic)
> >>>>
> >>>> If you want to stick with numbers, be aware that cpu numbers are not
> >>>> injective, so at some point we will need e.g. "8561.2", just so you're
> >>>> aware of the implications.    
> >>>
> >>> I think whatever we have here is only used internally for expansion (host-model)
> >>> and the user will use later the real name when available. (custom). So probably this
> >>> does not matter for a long time. But I might be wrong.
> >>> I tend to prefer gen15 over z15 but 856x has also its charm.  
> > 
> > FWIW, I'd prefer gen15 over 856x, but...  
> 
> I actually think that the cpu id would be a nice name for expansion because it is
> guarenteed to stay and it is unique and it allows to have a different content (if
> that would be necessary) for 2 gen15 machines.
> >   
> >>>     
> >>
> >> Another question would be, can we rename before the next QEMU release,
> >> so it will never be officially part of QEMU? Then we don't need aliases
> >> after all. Of course, distros have to take care of that as well, but
> >> that shouldn't be upstream QEMUs business.  
> > 
> > ...if we could do that, I'd like that even better.  
> 
> I dont think that I know the name in time before the next release.
> So lets go with gen15a/gen15b or 8561/8562?

I always have trouble remembering number combinations, so I'd vote for
gen15a/gen15b if the official names are not an option.

