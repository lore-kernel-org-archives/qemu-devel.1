Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC56DC3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A462064A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A462064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKVk-0007j2-OK
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCKTO-0006HP-DO
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCKTL-0006Px-SJ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCKTL-0006PY-KG
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:17:31 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 388CA3DE05
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:17:30 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n6so4567933wrm.20
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 02:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MOYlPRguPRrD1KGYJ7Kfm5he1pKx+lxYRTsa3YhWERc=;
 b=aof780KIKzmqGuEiLDOMRbgWW3klxnfJFx97HQXnXyS3Pa+Ipw8EM0ZThrBen1oADa
 kUVFfWfACOil1vrbcVpwznZEBQSSLT1qHCKJ6bYu7Vpp6zHXIoqu2+wKCcBreL8WTsX/
 T4LmVakwl6Wvysqvc0jLk3sOcB42vI0yyGmIKY5/20jXIyO7MrAFnv8pscbCMWDuJx6K
 vt1dtzuPICNscXq29m/hEO9HO23X1rYYgFX6PZiLmzxAEjfFIxhpFOvoMhjFFPqCSIK5
 k0Ns0dWlt0BxJEtDfoU13Pu8wXsrDKfiLjKxkT6YZ/minaZOrBwha5CIgI6TP7v651R0
 3Gbw==
X-Gm-Message-State: APjAAAW4s24ssvBJpzHmfv1QYogaRX9g0vaxOewByzlXcgSkIoo6uVZ0
 GjtSBzqHG3pso/IpIuN/dNX9hJ6csnPvomqDL+FTWbJe+9xHxi6iZ7wHJqgZQIRdxZeLFqZI1/T
 U4v9Wf1XXVErQrIQ=
X-Received: by 2002:a1c:9a95:: with SMTP id c143mr707726wme.89.1569230248920; 
 Mon, 23 Sep 2019 02:17:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzR/D46PMOyQ+Mr+Hj27/umcyFt2pPuVtMqoGhvFn8nRh3tXbAPYZ5TlVAiFWhwh++BcI86zQ==
X-Received: by 2002:a1c:9a95:: with SMTP id c143mr707711wme.89.1569230248712; 
 Mon, 23 Sep 2019 02:17:28 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g13sm10105993wrm.42.2019.09.23.02.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 02:17:28 -0700 (PDT)
Subject: Re: [PATCH v3 11/20] exec: Adjust notdirty tracing
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ef3e3279-b0dc-3e33-36fb-a1b020f7f310@redhat.com>
Date: Mon, 23 Sep 2019 11:17:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190922035458.14879-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/19 5:54 AM, Richard Henderson wrote:
> The memory_region_tb_read tracepoint is unreachable, since notdirty
> is supposed to apply only to writes.  The memory_region_tb_write
> tracepoint is mis-named, because notdirty is not only used for TB
> invalidation.  It is also used for e.g. VGA RAM updates and migration.
>=20
> Replace memory_region_tb_write with memory_notdirty_write_access,
> and place it in memory_notdirty_write_prepare where it can catch
> all of the instances.  Add memory_notdirty_set_dirty to log when
> we no longer intercept writes to a page.
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  exec.c       | 3 +++
>  memory.c     | 4 ----
>  trace-events | 4 ++--
>  3 files changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index 33bd0e36c1..7ce0515635 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2721,6 +2721,8 @@ void memory_notdirty_write_prepare(NotDirtyInfo *=
ndi,
>      ndi->size =3D size;
>      ndi->pages =3D NULL;
> =20
> +    trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
> +
>      assert(tcg_enabled());
>      if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_COD=
E)) {
>          ndi->pages =3D page_collection_lock(ram_addr, ram_addr + size)=
;
> @@ -2745,6 +2747,7 @@ void memory_notdirty_write_complete(NotDirtyInfo =
*ndi)
>      /* we remove the notdirty callback only if the code has been
>         flushed */
>      if (!cpu_physical_memory_is_clean(ndi->ram_addr)) {
> +        trace_memory_notdirty_set_dirty(ndi->mem_vaddr);
>          tlb_set_dirty(ndi->cpu, ndi->mem_vaddr);
>      }
>  }
> diff --git a/memory.c b/memory.c
> index b9dd6b94ca..57c44c97db 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -438,7 +438,6 @@ static MemTxResult  memory_region_read_accessor(Mem=
oryRegion *mr,
>          /* Accesses to code which has previously been translated into =
a TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_read(get_cpu_index(), addr, tmp, size);
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tm=
p, size);
> @@ -465,7 +464,6 @@ static MemTxResult memory_region_read_with_attrs_ac=
cessor(MemoryRegion *mr,
>          /* Accesses to code which has previously been translated into =
a TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_read(get_cpu_index(), addr, tmp, size);
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tm=
p, size);
> @@ -490,7 +488,6 @@ static MemTxResult memory_region_write_accessor(Mem=
oryRegion *mr,
>          /* Accesses to code which has previously been translated into =
a TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_write(get_cpu_index(), addr, tmp, size)=
;
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, t=
mp, size);
> @@ -515,7 +512,6 @@ static MemTxResult memory_region_write_with_attrs_a=
ccessor(MemoryRegion *mr,
>          /* Accesses to code which has previously been translated into =
a TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_write(get_cpu_index(), addr, tmp, size)=
;
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, t=
mp, size);
> diff --git a/trace-events b/trace-events
> index 823a4ae64e..20821ba545 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -52,14 +52,14 @@ dma_map_wait(void *dbs) "dbs=3D%p"
>  find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @=
 0x%" PRIx64
>  find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offse=
t, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRI=
x64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
>  ram_block_discard_range(const char *rbname, void *hva, size_t length, =
bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise:=
 %d fallocate: %d ret: %d"
> +memory_notdirty_write_access(uint64_t vaddr, uint64_t ram_addr, unsign=
ed size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
> +memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
> =20
>  # memory.c
>  memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_=
t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" =
size %u"
>  memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64=
_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64"=
 size %u"
>  memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, u=
int64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"=
PRIx64" size %u"
>  memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, =
uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%=
"PRIx64" size %u"
> -memory_region_tb_read(int cpu_index, uint64_t addr, uint64_t value, un=
signed size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, u=
nsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
>  memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, =
uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"P=
RIx64" size %u"
>  memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr,=
 uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"=
PRIx64" size %u"
>  flatview_new(void *view, void *root) "%p (root %p)"
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

