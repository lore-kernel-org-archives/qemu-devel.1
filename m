Received: from eggs.gnu.org ([2001:4830:134:3::10]:58228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e6ep1-00055v-Oi
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e6eoy-0005fh-Lt
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:39:23 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:29772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1e6eoy-0005fI-Ar
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:39:20 -0400
Date: Mon, 23 Oct 2017 17:39:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <99e54ab2-c5b4-cd67-428d-f012e62f8062@amsat.org>
Message-ID: <alpine.BSF.2.21.1710231733420.33277@zero.eik.bme.hu>
References: <20171023102903.256AF7456A0@zero.eik.bme.hu>
	<894e2612-fe81-03bc-84d1-79dd9b6392f5@amsat.org>
	<99e54ab2-c5b4-cd67-428d-f012e62f8062@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Fix compile with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Mon, 23 Oct 2017, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/23/2017 08:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 10/23/2017 07:24 AM, BALATON Zoltan wrote:
> [...]
>>>          info =3D g_new0(TPMInfoList, 1);
>>> +#ifdef CONFIG_TPM
>>>          info->value =3D tpm_backend_query_tpm(drv);
>>> -
>>> +#endif
>>>          if (!cur_item) {
>>>              head =3D cur_item =3D info;
>>>          } else {
>>> diff --git a/vl.c b/vl.c
>>> index 0723835..dbfd06d 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -4905,7 +4905,9 @@ int main(int argc, char **argv, char **envp)
>>>      res_free();
>>>
>>>      /* vhost-user must be cleaned up before chardevs.  */
>>> +#ifdef CONFIG_TPM
>>>      tpm_cleanup();
>>> +#endif
>>>      net_cleanup();
>>>      audio_cleanup();
>>>      monitor_cleanup();
>>
>> Can you instead add tpm_cleanup() in stubs/tpm.c?
>
> and tpm_backend_query_tpm() ;)

The v2 I've sent avoids #ifdefs outside tpm.c so isn't that acceptable? D=
o=20
we still need stubs for these? I don't understand how stubs are compiled=20
so if it's needed can you point me to an example what needs to be done to=
=20
add stubs for these? (I'm not familiar with this, just tried to fix a=20
compile problem I've met but I don't really know what's the correct way t=
o=20
fix this. I'd expect the author of the patch that broke it to fix it=20
instead or at least review this to avoid breaking it more.)

Regards,
BALATON Zoltan
