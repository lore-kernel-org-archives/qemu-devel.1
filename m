Received: from eggs.gnu.org ([2001:4830:134:3::10]:39105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cX92H-0001aB-FB
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cX92D-0000Pq-Fy
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:06:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cX92D-0000Pk-A0
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:05:57 -0500
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<CAAibmn3GJWWun69KCHp+0qCBo=fjg1_xg+R_o+Qyro48a7Y_zQ@mail.gmail.com>
	<20170123121204.547e6415@nial.brq.redhat.com>
	<CAAibmn1j8819O1UbSOQphe=2-uAt29uYQXhOkCnc_BKiYovD9w@mail.gmail.com>
	<20170127145737.3796d088@nial.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0356bad-17cf-657f-007b-a19e1c88d7a3@redhat.com>
Date: Fri, 27 Jan 2017 17:05:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170127145737.3796d088@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>



On 27/01/2017 14:57, Igor Mammedov wrote:
>> +    fadt->reset_register.space_id   = 1;
>> +    fadt->reset_register.bit_width = 8;
>> +    fadt->reset_register.address            = ICH9_RST_CNT_IOPORT;
> cpu_to_le64
> 
> + specify explicitly all fields of GAS structure: reset_register
> 
> + is reset_register applicable only to q35 or to both machine types?
> If it's only q35, you should do above only for it.
> 

It applies to i440FX as well.

Paolo
