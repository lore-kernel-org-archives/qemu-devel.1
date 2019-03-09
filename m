Received: from eggs.gnu.org ([209.51.188.92]:53219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2dJI-0000TF-1n
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2dJH-0003At-6b
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:50:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-8-philmd@redhat.com>
	<5166477f-67db-cf41-cdc9-a459597be80e@redhat.com>
	<390aa400-70ee-ac80-ba83-290875cca56c@redhat.com>
Date: Sat, 09 Mar 2019 15:44:42 +0100
In-Reply-To: <390aa400-70ee-ac80-ba83-290875cca56c@redhat.com> (Laszlo Ersek's
	message of "Fri, 8 Mar 2019 11:29:51 +0100")
Message-ID: <87pnr03y5h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/18] hw/nvram/fw_cfg: Add
 fw_cfg_common_unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

Laszlo Ersek <lersek@redhat.com> writes:

> On 03/08/19 07:55, Thomas Huth wrote:
>> On 08/03/2019 02.32, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Back in abe147e0ce4 when fw_cfg_add_file() was introduced, there

Suggest to say "commit abe147e0ce4".

>>> was no QOM design, object where not created and released at runtime.
>
> s/object where/objects were/
>
>>> Later 38f3adc34d finished the QOM conversion of the fw_cfg device,
>>> adding the fw_cfg_common_realize() method.
>
> (I'm not sure if 38f3adc34d "finished the QOM conversion", but that's
> just my lack of QOM knowledge. Hopefully someone can confirm whether
> this statement is accurate.)
>
>>> The time has come to add the equivalent destructor and release the
>>> memory allocated for 'files'.
>>=20
>> You should mention that the unrealize function is currently never called
>> since the object never gets destroyed (AFAIK). But I hope we can fix
>> that in the not so distant future, so:
>>=20
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>=20
>
> How about we delay this patch until such time the function is actually
> called?
>
> This series is already huge, and quite divergent considering its goals.
> (Please refer to the blurb.)
>
> I don't mind this patch, but I think it should either belong to a
> separate fw_cfg cleanup series (or "wave" if you like).
>
> Or else, we should have a bug reported somewhere public, ensuring that
> we eventually call the function introduced here. And then the commit
> message should spell out -- as you say -- that the function is not
> called yet, but it will be, because of <ticket-reference>.

I suspect filing a bug "somewhere" and making use of it would be much
more work than simply applying the fix.

I'm fine with including trivial patches for stuff you spot "on the way".
I'd be also fine with some patches spun off into a separate cleanup
series that L=C3=A1szl=C3=B3 doesn't have to review, if you can do that saf=
ely,
and with little effort.
