Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E73C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 21:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE322332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 21:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE322332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0YFw-0001z1-I5
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 17:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i0YF0-0001IJ-9s
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 17:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i0YEo-0007nw-47
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 17:34:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i0YEn-0007Ur-2G; Wed, 21 Aug 2019 17:33:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 53F3218C4260;
 Wed, 21 Aug 2019 21:33:32 +0000 (UTC)
Received: from [10.36.118.29] (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A46B65D6B0;
 Wed, 21 Aug 2019 21:33:30 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190821092252.26541-1-david@redhat.com>
 <20190821092252.26541-3-david@redhat.com>
 <dc42887a-f991-1fe0-36a7-a7804bc4a939@linaro.org>
 <60d60d82-0407-9549-09b8-ff35218a4e71@redhat.com>
 <8973f904-c171-bcdd-3f6e-5e18cb37035c@linaro.org>
 <1c0c597d-c851-4116-184e-6b35fae08011@redhat.com>
 <d46f1b05-ef1f-cf82-f49c-ef9eb814c10e@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <5bbdc8de-2526-2091-3d87-4c0945ce9442@redhat.com>
Date: Wed, 21 Aug 2019 23:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d46f1b05-ef1f-cf82-f49c-ef9eb814c10e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Wed, 21 Aug 2019 21:33:32 +0000 (UTC)
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

On 21.08.19 22:38, Richard Henderson wrote:
> On 8/21/19 12:36 PM, David Hildenbrand wrote:
>>>> There are certain cases where we can't get access to the raw host
>>>> page. Namely, cpu watchpoints, LAP, NODIRTY. In summary: this won't
>>>> as you describe. (my first approach did exactly this)
>>>
>>> NODIRTY and LAP are automatically handled via probe_write
>>> faulting instead of returning the address.  I think there
>>> may be a bug in probe_write at present not checking
>>
>> For LAP pages we immediately set TLB_INVALID_MASK again, to trigger a
>> new fault on the next write access (only). The could be handled in
>> tlb_vaddr_to_host(), simply returning the address to the page after
>> trying to fill the tlb and succeeding (I implemented that, that's the
>> easy part).
>=20
> Yes.
>=20
>> TLB_NOTDIRTY and TLB_MMIO are the real issue. We don't want to refault=
,
>> we want to treat that memory like IO memory and route it via
>> MemoryRegionOps() - e.g., watch_mem_ops() in qemu/exec.c. So it's not =
a
>> fault but IO memory.
>=20
> Watchpoints are not *really* i/o memory (unless of course it's a watchp=
oint on
> a device, which is a different matter), that's merely how we've chosen =
to
> implement it to force the memory operation through the slow path.  We c=
an, and
> probably should, implement this differently wrt probe_write.

Yes, I agree wrt probe_write.

>=20
> Real MMIO can only fault via cc->transaction_failed(), for some sort of=
 bus
> error.  Which s390x does not currently implement.  In the meantime, a
> probe_write proves that the page is at least mapped correctly, so we ha=
ve
> eliminated the normal access fault.

Yes, and that's all we care about on s390x.

>=20
> NOTDIRTY cannot fault at all.  The associated rcu critical section is u=
gly
> enough to make me not want to do anything except continue to go through=
 the
> regular MMIO path.
>=20
> In any case, so long as we eliminate *access* faults by probing the pag=
e table,
> then falling back to the byte-by-byte loop is, AFAICS, sufficient to im=
plement
> the instructions correctly.

"In any case, so long as we eliminate *access* faults by probing the
page table" - that's what I'm doing in this patch (and even more correct
in the prototype patch I shared), no? (besides the watchpoint madness bel=
ow)

"falling back to the byte-by-byte loop is, AFAICS, sufficient"

I don't think this is sufficient. E.g., LAP protected pages
(PAGE_WRITE_INV which immediately requires a new MMU walk on the next
access) will trigger a new MMU walk on every byte access (that's why I
chose to pre-translate in my prototype). If another CPU modified the
page tables in between, we could suddenly get a fault - although we
checked early. What am I missing?

>=20
>> probe_write() performs the MMU translation. If that succeeds, there is
>> no fault. If there are watchpoints, the memory is treated like IO and
>> memory access is rerouted. I think this works as designed.
>=20
> Well, if BP_STOP_BEFORE_ACCESS, then we want to raise a debug exception=
 before
> any changes are made.  If !BP_STOP_BEFORE_ACCESS, then we longjmp back =
to the
> main cpu loop and single-step the current instruction.

I see that we use BP_STOP_BEFORE_ACCESS for PER (Program Event
Recording) on s390x. I don't think that's correct. We want to get
notified after the values were changed.

"A storage-alteration event occurs whenever a CPU,
by using a logical or virtual address, makes a store
access without an access exception to the storage
area designated by control registers 10 and 11. ..."

"For a PER instruction-fetching nullification event, the
unit of operation is nullified. For other PER events,
the unit of operation is completed"

Oh man, why is everything I take a look at broken.

>=20
> In the latter case, if the instruction has had any side effects prior t=
o the
> longjmp, they will be re-done when we re-start the current instruction.
>=20
> To me this seems like a rather large bug in our implementation of watch=
points,
> as it only really works properly for simple load/store/load-op-store ty=
pe
> instructions.  Anything that works on many addresses and doesn't delay =
side
> effects until all accesses are complete will Do The Wrong Thing.
>=20
> The fix, AFAICS, is for probe_write to call check_watchpoint(), so that=
 we
> take the debug exit early.

Indeed. I see what you mean now. (I was ignoring the "before access"
because I was assuming we don't need it on s390x)

probe_write() would have to check for all BP_STOP_BEFORE_ACCESS watchpoin=
ts.

>=20
>> You mean two pages I assume. Yeah, I could certainly simplify the
>> prototype patch I have here quite a lot. 2 pages should be enough for
>> everybody ;)
>=20
> Heh.  But, seriously, TARGET_PAGE_SIZE bytes is enough at one go, witho=
ut
> releasing control so that interrupts etc may be recognized.

Yes, that's what I mean, TARGET_PAGE_SIZE, but eventually crossing a
page boundary. The longer I stare at the MVCL code, the more broken it
is. There are more nice things buried in the PoP. MVCL does not detect
access exceptions beyond the next 2k. So we have to limit it there
differently.

So what I understand is that

- we should handle watchpoints in probe_write()
- not bypass IO memory (especially NOTDIRTY). We cannot always relay on
  getting access to a host page.

Thanks!

--=20

Thanks,

David / dhildenb

