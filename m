Received: from eggs.gnu.org ([2001:4830:134:3::10]:54490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e0QdC-00051S-Bb
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e0Qd2-000378-NT
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:17:26 -0400
Received: from chuckie.co.uk ([82.165.15.123]:43521
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e0Qd2-00035m-GG
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:17:16 -0400
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
	<1507211474-188400-34-git-send-email-imammedo@redhat.com>
	<d83f1682-840e-87b7-9e65-8b83af9d83b1@ilande.co.uk>
	<20171006093721.5abd84ef@nial.brq.redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4c241063-f533-0dc8-03bb-932f5250168f@ilande.co.uk>
Date: Fri, 6 Oct 2017 12:17:06 +0100
MIME-Version: 1.0
In-Reply-To: <20171006093721.5abd84ef@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 33/40] sparc: sparc: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, atar4qemu@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/10/17 08:37, Igor Mammedov wrote:

>> No objections to this patch but just to confirm from the previous
>> discussion that the cpu type gets parsed in a way such that an existing
>> -cpu "TI SuperSparc II" option gets mapped to the correct
>> "TI-SuperSparc-II" type? Presumably this is now handled at a different
>> level?
> old way still works, see sparc_cpu_type_name()
> 
> call chain is
>  vl.c:
>    machine->cpu_type = cpu_parse_cpu_model()
>                           -> sparc_cpu_class_by_name()
>                                -> sparc_cpu_type_name()

Yeah, that's what I was fairly sure the outcome was but couldn't quite
see it in that patchset. In that case:

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
