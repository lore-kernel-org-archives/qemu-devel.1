Received: from eggs.gnu.org ([2001:4830:134:3::10]:50170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f8TRG-0002N6-Fj
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f8TRB-0007AL-HM
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:26:38 -0400
References: <1523472120-56496-1-git-send-email-spopovyc@redhat.com>
	<1523472120-56496-2-git-send-email-spopovyc@redhat.com>
	<20180413075739.GC14855@in.ibm.com>
	<e651fb40-2e44-73ed-6082-d9e497073e69@redhat.com>
	<20180417035842.GA3942@in.ibm.com>
	<20180417061900.GB2317@umbus.fritz.box>
From: Serhii Popovych <spopovyc@redhat.com>
Message-ID: <6b53a80a-6c28-1897-9ab9-ffc63a96e6ba@redhat.com>
Date: Tue, 17 Apr 2018 19:26:22 +0300
MIME-Version: 1.0
In-Reply-To: <20180417061900.GB2317@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="t6f1TnyQ3tSabTKbH43XkJ0dek3nYIgft"
Subject: Re: [Qemu-devel] [PATCH for 2.13 v3 1/2] spapr: Add ibm,
 max-associativity-domains property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t6f1TnyQ3tSabTKbH43XkJ0dek3nYIgft
From: Serhii Popovych <spopovyc@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Message-ID: <6b53a80a-6c28-1897-9ab9-ffc63a96e6ba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.13 v3 1/2] spapr: Add ibm,
 max-associativity-domains property
References: <1523472120-56496-1-git-send-email-spopovyc@redhat.com>
 <1523472120-56496-2-git-send-email-spopovyc@redhat.com>
 <20180413075739.GC14855@in.ibm.com>
 <e651fb40-2e44-73ed-6082-d9e497073e69@redhat.com>
 <20180417035842.GA3942@in.ibm.com> <20180417061900.GB2317@umbus.fritz.box>
In-Reply-To: <20180417061900.GB2317@umbus.fritz.box>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

David Gibson wrote:
> On Tue, Apr 17, 2018 at 09:28:42AM +0530, Bharata B Rao wrote:
>> On Mon, Apr 16, 2018 at 07:47:29PM +0300, Serhii Popovych wrote:
>>> Bharata B Rao wrote:
>>>> On Wed, Apr 11, 2018 at 02:41:59PM -0400, Serhii Popovych wrote:
>>>>> Now recent kernels (i.e. since linux-stable commit a346137e9142
>>>>> ("powerpc/numa: Use ibm,max-associativity-domains to discover possi=
ble nodes")
>>>>> support this property to mark initially memory-less NUMA nodes as "=
possible"
>>>>> to allow further memory hot-add to them.
>>>>>
>>>>> Advertise this property for pSeries machines to let guest kernels d=
etect
>>>>> maximum supported node configuration and benefit from kernel side c=
hange
>>>>> when hot-add memory to specific, possibly empty before, NUMA node.
>>>>>
>>>>> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
>>>>> ---
>>>>>  hw/ppc/spapr.c | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>>> index a81570e..c05bbad 100644
>>>>> --- a/hw/ppc/spapr.c
>>>>> +++ b/hw/ppc/spapr.c
>>>>> @@ -910,6 +910,13 @@ static void spapr_dt_rtas(sPAPRMachineState *s=
papr, void *fdt)
>>>>>          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
>>>>>          cpu_to_be32(max_cpus / smp_threads),
>>>>>      };
>>>>> +    uint32_t maxdomains[] =3D {
>>>>> +        cpu_to_be32(4),
>>>>> +        cpu_to_be32(0),
>>>>> +        cpu_to_be32(0),
>>>>> +        cpu_to_be32(0),
>>>>> +        cpu_to_be32(nb_numa_nodes - 1),
>>>>> +    };
>>>>>
>>>>>      _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas"));
>>>>>
>>>>> @@ -946,6 +953,9 @@ static void spapr_dt_rtas(sPAPRMachineState *sp=
apr, void *fdt)
>>>>>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-point=
s",
>>>>>                       refpoints, sizeof(refpoints)));
>>>>>
>>>>> +    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
>>>>> +                     maxdomains, sizeof(maxdomains)));
>>>>> +
>>>>>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
>>>>>                            RTAS_ERROR_LOG_MAX));
>>>>>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
>>>>
>>>> This commit causes hash guest with latest guest kernel to hang at ea=
rly boot.
>>>
>>> I use v4.16 tag from stable and can't reproduce on P8 machine reporte=
d
>>> issue.
>>>
>>> Could you please share more details about your setup, kernel commit i=
d
>>> you spot problem?
>>
>> I am on 4.16.0-rc7 (commit id: 0b412605ef5f)
>>
>> BTW this happens only for non-NUMA guest.
>=20
> Ah, that might explain it.  With no NUMA nodes specified, I think this
> code will put a -1 into the max-associativity-domains property, which
> is probably causing the mess.  If we don't have NUMA (nb_numa_nodes =3D=
=3D
> 0) we probably want to either omit the property entirely, or clamp
> that 5th cell to 0.
>=20
Ok, proposed fix already posted to qemu-devel. Sorry forgot to CC.

Mail subject contains (w/o quotas):
"spapr: Correct max associativity domains value for non-NUMA configs"

Tested with v4.16 tag:

  o Before : non-NUMA configs: able to reproduce, stall during boot
  o After  : non-NUMA configs: not reproducible, boot is ok

--=20
Thanks,
Serhii


--t6f1TnyQ3tSabTKbH43XkJ0dek3nYIgft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJa1iA1AAoJEBTawMmQ61bBeb8IALJSmVXHX6TjuHPa+Rwd/ImS
fY8kturMCfgqhrgi0Ndueje0MstoSwa2R7Ytpmg/FdIpFCsv9NfbbGAFZU7jXZSO
Fxq8MlyRqeVMhXl89y3wjs8EGhnHm9ZYmRK+BGZGfkiajKGveumKNHzQKr++iEff
23VrHBy82xSUsEpmceyq5qcTHVp4DWvdVqSTLKYnMieJQalETf+iX4mWCPLmqoji
xf3kM90Wv1iY4BmiKZr1HWrNrqDiRhByJpGyZzAyl6bEHxGWbulBi2BJcHD+ozzZ
qQCe3UEP4MhhqEXe3AfYSIlMF+vSOB3mu9dtW2Wcg2k2LCB8xDMcF/q1Nspiq0s=
=3533
-----END PGP SIGNATURE-----

--t6f1TnyQ3tSabTKbH43XkJ0dek3nYIgft--
