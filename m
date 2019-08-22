Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95124C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 07:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590AA20870
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 07:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590AA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0h8J-0007dI-FX
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 03:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i0h6P-0006hQ-HD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 03:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i0h6G-0004vW-5N
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 03:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i0h6F-0004rj-TK; Thu, 22 Aug 2019 03:01:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4208130044CC;
 Thu, 22 Aug 2019 07:01:34 +0000 (UTC)
Received: from [10.36.116.221] (ovpn-116-221.ams2.redhat.com [10.36.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84B325C205;
 Thu, 22 Aug 2019 07:01:27 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190821092252.26541-1-david@redhat.com>
 <20190821092252.26541-3-david@redhat.com>
 <dc42887a-f991-1fe0-36a7-a7804bc4a939@linaro.org>
 <60d60d82-0407-9549-09b8-ff35218a4e71@redhat.com>
 <8973f904-c171-bcdd-3f6e-5e18cb37035c@linaro.org>
 <1c0c597d-c851-4116-184e-6b35fae08011@redhat.com>
 <d46f1b05-ef1f-cf82-f49c-ef9eb814c10e@linaro.org>
 <5bbdc8de-2526-2091-3d87-4c0945ce9442@redhat.com>
 <a8b1436d-a634-d767-8861-460c50acecb2@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <eb4696dc-f95d-e934-3ff4-24364c161109@redhat.com>
Date: Thu, 22 Aug 2019 09:01:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a8b1436d-a634-d767-8861-460c50acecb2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 22 Aug 2019 07:01:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 2/4] s390x/tcg: Introduce
 probe_read_access()
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.08.19 00:31, Richard Henderson wrote:
> On 8/21/19 2:33 PM, David Hildenbrand wrote:
>>> NOTDIRTY cannot fault at all.  The associated rcu critical section is=
 ugly
>>> enough to make me not want to do anything except continue to go throu=
gh the
>>> regular MMIO path.
>>>
>>> In any case, so long as we eliminate *access* faults by probing the p=
age table,
>>> then falling back to the byte-by-byte loop is, AFAICS, sufficient to =
implement
>>> the instructions correctly.
>>
>> "In any case, so long as we eliminate *access* faults by probing the
>> page table" - that's what I'm doing in this patch (and even more corre=
ct
>> in the prototype patch I shared), no? (besides the watchpoint madness =
below)
>=20
> Correct.
>=20
> My main objection to your current patch is that you perform the access =
checks
> within MVC, and then do some more tlb lookups in fast_memmove.

Right, however I think splitting up both steps is nicer (especially if
we mix and match memmove and memset in MVCLE later). Maybe combining a
tuned-up probe_write() with something similar (but different to)
access_prepare().

General changes:

1. Check watchpoints in probe_write()

2. Make probe_write() bail out if it would cross pages() - caller has to
assure it falls into a single page (TARGET_PAGE_SIZE ?).

3. Return a pointer from probe_write()
-> If NULL is returned, reads/writes have to go via memops, e.g., single
byte access

4. Make probe_write() return addresses of TLB entries that are already
invalid again (-> LAP)


What I propose for s390x:

1. access_prepare(): Collect the pointers using probe_write() - maximum
is two pages. If we get NULL, there is no fault but we have to fallback
to read/write using memops.

2. access_memset() / access_set() / access_move() ... pass the access
information we collected. Prototype I shared can be heavily simplified -
don't fall back to paddrs but instead do single-byte access, don't allow
flexible array of pages, etc.

3. First convert MVC to the new access mechanism, later fix + convert
the others.

>=20
> I think that fast_memmove is where the access checks should live.  That=
 allows
> incremental improvement to combine access checks + host address lookup,=
 which
> cannot currently be done in one step with existing interfaces.
>=20
> I guess you would still want access checks within MVC for the case in w=
hich you
> must fall back to byte-by-byte because of destructive overlap.

That's why I think introducing a new set of helpers makes sense. Once
all users of fast_memmove() etc are gone, we can then throw them away.

>=20
>> "falling back to the byte-by-byte loop is, AFAICS, sufficient"
>>
>> I don't think this is sufficient. E.g., LAP protected pages
>> (PAGE_WRITE_INV which immediately requires a new MMU walk on the next
>> access) will trigger a new MMU walk on every byte access (that's why I
>> chose to pre-translate in my prototype).
>=20
> LAP protected pages is exactly why probe_write should return the host a=
ddress,
> so that we can do the access check + host address lookup in one step.
>=20

Yes, this should also be done in tlb_vaddr_to_host() - but as we'll be
converting to a probe_write() thingy, it might not be required to handle
the special "TLB_INVALID_MASK set after tlb_fill()" case.

> But in the meantime...
>=20
>> If another CPU modified the
>> page tables in between, we could suddenly get a fault - although we
>> checked early. What am I missing?
>=20
> You're concerned with a bare write to the page table by cpu B, while cp=
u A is
> executing, and before cpu B issues the cross-cpu tlb flush?

Not bare writes, these are invalid. Take IPTE for example. Set the
invalid bit, then do a sync CPU flush.

If we re-translate a vaddr after probe_write() - which would currently
happen in case of LAP - then we could suddenly run into the invalid bit,
triggering a fault. The sync CPU flush still wasn't processed, but we
see the "invalid" bit early because we decided to re-translate after
already modifying memory. This re-translation really has to be avoided.

>=20
> The tlb victim cache should prevent having to re-read a tlb entry from =
memory,
> at least for MVC.  The unlimited size we currently support for MVCL and=
 MVCLE
> could act weird, but would be fixed by limiting the execution as discus=
sed.

Yes, MVCL/MVCLE need a major overhaul. But good to know that a second
tlb_fill() will not result in the other TLB entry to suddenly get
invalid and require a new MMU translation (-> victim cache). That's
another concern I had.

>=20
> Honestly, the os has to make sure that the page remains valid until aft=
er the
> flush completes, otherwise it's an os bug.  The cross-cpu tlb flush hap=
pens via
> async_run_on_cpu, and of course never occurs while we are executing a T=
B.  Yet
> another reason to limit the amount of work any one instruction does.  ;=
-)

In my example, the page would still be valid, however we the invalid bit
has already been set. The next MMU translation would choke on that and
trigger a fault.

I can only see this (re-translation) happening for LAP right now. And
LAP pages (lowcore) should be always mapped, so I don't think this is a
very important case to handle.

>=20
>=20
>> I see that we use BP_STOP_BEFORE_ACCESS for PER (Program Event
>> Recording) on s390x. I don't think that's correct. We want to get
>> notified after the values were changed.
>>
>> "A storage-alteration event occurs whenever a CPU,
>> by using a logical or virtual address, makes a store
>> access without an access exception to the storage
>> area designated by control registers 10 and 11. ..."
>>
>> "For a PER instruction-fetching nullification event, the
>> unit of operation is nullified. For other PER events,
>> the unit of operation is completed"
>>
>> Oh man, why is everything I take a look at broken.
>=20
> Heh.
>=20
>>> In the latter case, if the instruction has had any side effects prior=
 to the
>>> longjmp, they will be re-done when we re-start the current instructio=
n.
>>>
>>> To me this seems like a rather large bug in our implementation of wat=
chpoints,
>>> as it only really works properly for simple load/store/load-op-store =
type
>>> instructions.  Anything that works on many addresses and doesn't dela=
y side
>>> effects until all accesses are complete will Do The Wrong Thing.
>>>
>>> The fix, AFAICS, is for probe_write to call check_watchpoint(), so th=
at we
>>> take the debug exit early.
>>
>> Indeed. I see what you mean now. (I was ignoring the "before access"
>> because I was assuming we don't need it on s390x)
>>
>> probe_write() would have to check for all BP_STOP_BEFORE_ACCESS watchp=
oints.
>=20
> !BP_STOP_BEFORE_ACCESS watchpoints exit to the main loop as well, so th=
at it
> can restart and then single-step the current instruction.
>=20
> We need it the check in probe_write for all cases.

Thanks for the clarification!

>=20
>> Yes, that's what I mean, TARGET_PAGE_SIZE, but eventually crossing a
>> page boundary. The longer I stare at the MVCL code, the more broken it
>> is. There are more nice things buried in the PoP. MVCL does not detect
>> access exceptions beyond the next 2k. So we have to limit it there
>> differently.
>=20
> That language is indeed odd.
>=20
> The only reading of that paragraph that makes sense to me is that the h=
ardware
> *must* interrupt MVCL after every 2k bytes processed.  The idea that th=
e user
> can magically write to a read-only page simply by providing length =3D =
2MB and
> page that is initially writable is dumb.  I cannot imagine that is a co=
rrect
> reading.
>=20
> Getting clarification from an IBM engineer on that would be good; other=
wise I
> would just ignore that and proceed as if all access checks are performe=
d.
>=20
>> So what I understand is that
>>
>> - we should handle watchpoints in probe_write()
>> - not bypass IO memory (especially NOTDIRTY). We cannot always relay o=
n
>>   getting access to a host page.
>=20
> Correct.
>=20
>=20
> r~
>=20


--=20

Thanks,

David / dhildenb

