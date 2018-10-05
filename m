Received: from eggs.gnu.org ([2001:4830:134:3::10]:60031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g8Tzj-0001Np-DX
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g8Tze-0000YE-Nt
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:34:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g8Tzc-0000WD-TR
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:34:26 -0400
References: <20181004151429.7232-1-crosa@redhat.com>
	<20181004151429.7232-7-crosa@redhat.com>
	<d81c7840-efd9-336c-9538-b032d6c54bdb@redhat.com>
	<0abf928c-2bca-1303-118d-e53be021168f@redhat.com>
	<c67eb021-c094-4d5f-e0a0-572ecabdc0ee@redhat.com>
	<746cb295-73fa-fd8c-5b0c-037914f7296c@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <01b4cb47-7556-cd62-7c05-8d59f6366d5f@redhat.com>
Date: Fri, 5 Oct 2018 13:34:15 -0400
MIME-Version: 1.0
In-Reply-To: <746cb295-73fa-fd8c-5b0c-037914f7296c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] Acceptance Tests: add variants
 definition for architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 10/5/18 1:30 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 05/10/2018 19:07, Cleber Rosa wrote:
>> On 10/5/18 12:32 PM, Eric Blake wrote:
>>> On 10/5/18 11:24 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Hi Cleber,
>>>>
>>>> On 04/10/2018 17:14, Cleber Rosa wrote:
>>>>> One of the Avocado features relevant to virtualization testing is t=
he
>>>>> ability to reuse tests in different scenarios, known as variants.
>>>>> This adds a JSON based variants file, that can be used to run most
>>>>> tests in a number of different architectures.=C2=A0 It can be run w=
ith:
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 $ avocado run \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --json-variants-load=3Dtests/accepta=
nce/variants/arch.json \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --filter-by-tags=3D'-x86_64' -- test=
s/acceptance/
>>>
>>>>> +++ b/tests/acceptance/variants/arch.json
>>>>> @@ -0,0 +1 @@
>>>>> +[{"paths":["/run/*"],"variant":[["/run/aarch64",[["/run/aarch64",
>>>>> "arch", "aarch64"]]]],"variant_id":
>>>>> "aarch64"},{"paths":["/run/*"],"variant":[["/run/ppc",[["/run/ppc",
>>>>> "arch", "ppc"]]]],"variant_id":
>>>>> "ppc"},{"paths":["/run/*"],"variant":[["/run/ppc64",[["/run/ppc64",
>>>>> "arch", "ppc64"]]]],"variant_id":
>>>>> "ppc64"},{"paths":["/run/*"],"variant":[["/run/s390x",[["/run/s390x=
",
>>>>> "arch", "s390x"]]]],"variant_id":
>>>>> "s390x"},{"paths":["/run/*"],"variant":[["/run/x86_64",[["/run/x86_=
64",
>>>>> "arch", "x86_64"]]]],"variant_id": "x86_64"}]
>>>>>
>>>>
>>>> Is this generated? (thinking about the other archs supported).
>>>>
>>
>> It's generated and kept on every job result (jobdata/variants.json).
>> Basically, you'd use any varianter plugin on a job, and then you can
>> reuse the JSON generated on other jobs.
>>
>> TBH, I tweaked this one a bit.
>>
>>>> You should use some linter ;)
>>
>> I missed your point here... do you mean the style is not ideal?
>=20
> As meant "pretty printer" :)
>=20
> [
>   {
>     "paths": [
>       "/run/*"
>     ],
>     "variant": [
>       [
>         "/run/aarch64",
>         [
>           [
>             "/run/aarch64",
>             "arch",
>             "aarch64"
>           ]
>         ]
>       ]
>     ],
>     "variant_id": "aarch64"
>   },
>   ...
>=20
> But since it is generated I'd rather generate it...

Actually, I think it's a good idea indeed to pretty print it, "python -m
json.tool" should do the job.

Thanks,
- Cleber.

>=20
>>>
>>> Also, that's a long line, which will probably get longer as more supp=
ort
>>> is added. Beyond 990 bytes, it starts risking problems with corruptio=
n
>>> over email. It's also hard to view what changes incrementally if the
>>> single line changes. Is there a way to pretty-print things across
>>> multiple lines, for shorter lines and easier reading of future diffs?
>>>
>>
>> Yes, good point.  I'll pretty print it.
>>
>> Just a disclaimer: I've chosen to use a JSON variants because it's a
>> core Avocado feature (doesn't require any external plugin), and the
>> results are 100% reproducible (the variants are static).  In the futur=
e,
>> we may consider also shipping (and depending) on other variants.
>>
>> One idea that is being maturing (and prototype) is a native QEMU
>> varianter.  There's some info here:
>>
>> https://trello.com/c/qW4kMw50/32-guest-abi-machine-type-cpu-model-test=
-cases
>>
>> Regards,
>> - Cleber.
>>
