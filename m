Received: from eggs.gnu.org ([2001:4830:134:3::10]:52043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Rhi-0006d1-7M
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Rhh-0000oQ-C0
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:47:38 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:34375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9Rhh-0000nX-7b
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:47:37 -0400
Received: by mail-oi0-x22d.google.com with SMTP id e23-v6so7377448oiy.1
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 01:47:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e5447136-8de7-73f3-ca6d-0c7a1fe11abe@kaod.org>
References: <20180413075200.15217-1-clg@kaod.org>
	<20180419165800.GA2731@work-vm>
	<e5447136-8de7-73f3-ca6d-0c7a1fe11abe@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 09:47:16 +0100
Message-ID: <CAFEAcA9hZ83_jwFi-=HhEf7KS6=F3KGuA++adfvqAiTy+rVZ8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Paolo Bonzini <pbonzini@redhat.com>

On 20 April 2018 at 07:59, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello David,
>
> On 04/19/2018 06:58 PM, Dr. David Alan Gilbert wrote:
>> * C=C3=A9dric Le Goater (clg@kaod.org) wrote:
>>> @@ -1823,6 +1831,7 @@ void qemu_ram_set_idstr(RAMBlock *new_block, cons=
t char *name, DeviceState *dev)
>>>          }
>>>      }
>>>      pstrcat(new_block->idstr, sizeof(new_block->idstr), name);
>>> +    new_block->flags |=3D RAM_MIGRATABLE;
>>>
>>>      rcu_read_lock();
>>>      RAMBLOCK_FOREACH(block) {
>>> @@ -1845,6 +1854,7 @@ void qemu_ram_unset_idstr(RAMBlock *block)
>>>       */
>>>      if (block) {
>>>          memset(block->idstr, 0, sizeof(block->idstr));
>>> +        block->flags &=3D ~RAM_MIGRATABLE;
>>>      }
>>>  }
>>
>> Why in qemu_ram_set_idstr and qemu_ram_(un)set_idstr ?  It seems an
>> odd place to put them.
>
> The only place where this routines are called is from vmstate_un/register=
_ram()
> It seemed unnecessary to add an extra interface qemu_ram_un/set_migratabl=
e().

Why not set the flags in vmstate_{register,unregister}_ram() ?

thanks
-- PMM
