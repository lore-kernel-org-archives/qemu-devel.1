Received: from eggs.gnu.org ([2001:4830:134:3::10]:47231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDRCc-0006Dc-CO
	for qemu-devel@nongnu.org; Tue, 01 May 2018 05:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDRCb-0001H5-Bt
	for qemu-devel@nongnu.org; Tue, 01 May 2018 05:04:02 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:44762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDRCb-0001Gs-5N
	for qemu-devel@nongnu.org; Tue, 01 May 2018 05:04:01 -0400
Received: by mail-ot0-x232.google.com with SMTP id g7-v6so12354388otj.11
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 02:04:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9a5497c5-555e-c556-f14c-570fb385ae17@amsat.org>
References: <20180213040809.26021-1-f4bug@amsat.org>
	<20180213040809.26021-21-f4bug@amsat.org>
	<CAFEAcA_r2WNVEkE5-p+VuH8f1XnDzHMkUNgNSMrV1ZTkHv4=AQ@mail.gmail.com>
	<20180430134929.edf3vsx4csvsydxi@toto>
	<9a5497c5-555e-c556-f14c-570fb385ae17@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 May 2018 10:03:40 +0100
Message-ID: <CAFEAcA8Oy=z_EfGPgWNyHMOqry=8ziEtbQXfT8qNZtrQExv9rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v13 20/30] sdbus: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 1 May 2018 at 04:35, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote=
:
> On 04/30/2018 10:49 AM, Edgar E. Iglesias wrote:
>> On Fri, Apr 27, 2018 at 12:55:21PM +0100, Peter Maydell wrote:
>>> On 13 February 2018 at 04:07, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>>>
>>>> @@ -39,6 +45,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, u=
int8_t *response)
>>>>  {
>>>>      SDState *card =3D get_card(sdbus);
>>>>
>>>> +    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->c=
rc);
>>>>      if (card) {
>>>>          SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
>>>
>>> Hi -- as a result of this trace event being added, we now get
>>> warnings from Coverity that it might use uninitialized data
>>> (CID1386074, CID1390571, CID1386072, CID1386076). This is because not
>>> all of our SD
>>> controllers bother to initialize req->crc, because up til now
>>> nothing in the SD code looks at it. (I think at least bcm2835_sdhost.c
>>> sdhci.c and ssi-sd.c do this).
>
> I was pretty sure we ran Coverity before the stable release :|
> Maybe they added new 'uninitialized data' checks recently.

No, we didn't get a coverity run for a long time (a combination
of Scan being down and then requiring a new version of the local
build tools, which we didn't realize because the website didn't
give a useful error message for that case). So this most recent
run has brought up a pile of accumulated issues since about
mid-february.

thanks
-- PMM
