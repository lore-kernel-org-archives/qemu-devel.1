Received: from eggs.gnu.org ([209.51.188.92]:57952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2Gf1-0003tA-Ug
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2Gf0-0001M0-3d
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:39:42 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190308131445.17502-1-armbru@redhat.com>
	<20190308083958-mutt-send-email-mst@kernel.org>
Date: Fri, 08 Mar 2019 15:39:26 +0100
In-Reply-To: <20190308083958-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Fri, 8 Mar 2019 08:41:29 -0500")
Message-ID: <87o96lbfc1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/12] pc: Support firmware
 configuration with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, lersek@redhat.com

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Mar 08, 2019 at 02:14:33PM +0100, Markus Armbruster wrote:
>> Based-on: <20190308094610.21210-1-armbru@redhat.com>
>>=20
>> v3:
>> * PATCH 05: Commit message tidied up [Philippe, L=C3=A1szl=C3=B3]
>> * PATCH 06: Comment tidied up [checkpatch]
>> * PATCH 12: Comment polish [L=C3=A1szl=C3=B3]
>>=20
>> v2:
>> * PATCH 05,06: New [Philippe]
>> * PATCH 07: Old PATCH 5 rebased onto new patches, with new comment
>>   [Philippe]
>> * PATCH 08+10: New, factored out of old PATCH 6 [by Philippe]
>> * PATCH 09: New [by Philippe]
>> * PATCH 11: Remainder of old PATCH 6, with FIXME resolved, literal
>>   4096 de-duplicated [L=C3=A1szl=C3=B3], extraneous error check deleted
>>   [L=C3=A1szl=C3=B3], and comment typos fixed
>> * PATCH 12: New
>>=20
>> Markus Armbruster (9):
>>   qdev: Fix latent bug with compat_props and onboard devices
>>   qom: Move compat_props machinery from qdev to QOM
>>   vl: Fix latent bug with -global and onboard devices
>>   sysbus: Fix latent bug with onboard devices
>>   vl: Improve legibility of BlockdevOptions queue
>>   vl: Factor configure_blockdev() out of main()
>>   vl: Create block backends before setting machine properties
>>   pc: Support firmware configuration with -blockdev
>>   docs/interop/firmware.json: Prefer -machine to if=3Dpflash
>>=20
>> Philippe Mathieu-Daud=C3=A9 (3):
>>   pflash_cfi01: Add pflash_cfi01_get_blk() helper
>>   pc_sysfw: Remove unused PcSysFwDevice
>>   pc_sysfw: Pass PCMachineState to pc_system_firmware_init()
>
> OK looks good to me.
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!

> Paolo will you be merging this?

Alternatively, I can do the pull request myself.  Paolo, would you like
me to?
