Received: from eggs.gnu.org ([2001:4830:134:3::10]:39391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdHq9-0003Ra-EO
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdHq6-00083E-9H
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:19:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdHq6-00081I-4M
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:19:38 -0400
References: <1531236069-7500-1-git-send-email-viktor.prutyanov@virtuozzo.com>
	<20180711160025.GU7451@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5e03b9eb-22ce-69bf-ca04-a17201834dfb@redhat.com>
Date: Wed, 11 Jul 2018 18:19:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180711160025.GU7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump: add kernel_gs_base to QEMU CPU state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, rkagan@virtuozzo.com

On 11/07/2018 18:00, Eduardo Habkost wrote:
>> @@ -237,7 +237,7 @@ int x86_cpu_write_elf32_note(WriteCoreDumpFunction=
 f, CPUState *cs,
>>   * please count up QEMUCPUSTATE_VERSION if you have changed definitio=
n of
>>   * QEMUCPUState, and modify the tools using this information accordin=
gly.
> Where are the tools using this information, that need to be
> updated?  Won't this break existing versions of those tools?

I think it's okay to _not_ change the version, since the format is
backwards-compatible.  Each QEMUCPUState struct is in a separate ELF
note, and the presence of the new field is visible in both 1) the size
of the note 2) the size field of the struct.

Another possibility is to stash kernel_gs_base in cr[1].  This approach
doesn't scale, but the word is otherwise unused if we want to make it
super safe.  I don't recommend it.

Paolo


> Is the dump format and pointers to available tools documented
> somewhere?
>=20
>=20
