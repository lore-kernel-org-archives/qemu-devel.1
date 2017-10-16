Received: from eggs.gnu.org ([2001:4830:134:3::10]:45007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e48lL-00076j-IE
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e48lG-0008K8-Oo
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e48lG-0008Jo-Ir
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:01:06 -0400
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016165916.GI3246@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c14ed02-1f1c-a093-52ac-632f61a68a6f@redhat.com>
Date: Mon, 16 Oct 2017 19:01:01 +0200
MIME-Version: 1.0
In-Reply-To: <20171016165916.GI3246@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/6] CLI: add -paused option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, cohuck@redhat.com

On 16/10/2017 18:59, Eduardo Habkost wrote:
>> +DEF("paused", HAS_ARG, QEMU_OPTION_paused, \
>> +    "-paused [state=]postconf|preconf\n"
>> +    "                postconf: pause QEMU after machine is initialized\n"
>> +    "                preconf: pause QEMU before machine is initialized\n",
>> +    QEMU_ARCH_ALL)
> I would like to allow pausing before machine-type is selected, so
> management could run query-machines before choosing a
> machine-type.  Would that need a third "-pause" mode, or will we
> be able to change "preconf" to pause before select_machine() is
> called?
> 
> The same probably applies to other things initialized before
> machine_run_board_init() that could be configurable using QMP,
> including but not limited to:
> * Accelerator configuration
> * Registering global properties
> * RAM size
> * SMP/CPU configuration

Should (or could) "-M none" be changed in a backwards-compatible way to
allow such preconfiguration?  For example

  qemu -M none -monitor stdio
  (qemu) machine-set-options pc,accel=kvm
  (qemu) c

Paolo
