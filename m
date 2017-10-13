Received: from eggs.gnu.org ([2001:4830:134:3::10]:38637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e32Zc-00074m-V9
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e32Zb-0004vv-Vv
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:12:32 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:55784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e32Zb-0004vD-Pk
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:12:31 -0400
Received: by mail-wr0-x230.google.com with SMTP id 22so1404005wrb.12
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:12:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK7MW5kY5eaiHGyk7hvxKyOBNJi7MHo9warfXbSp4LzPA@mail.gmail.com>
References: <1507751249-3035-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CK7MW5kY5eaiHGyk7hvxKyOBNJi7MHo9warfXbSp4LzPA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Oct 2017 17:12:10 +0100
Message-ID: <CAFEAcA_V-ZS+O_BsEU6OJuT_hE-RXw0dTaJbZgY-BW8soRv3vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] tpm: Use EMSGSIZE instead of EBADMSG to
 compile on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On 13 October 2017 at 12:14, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Hi
>
> On Wed, Oct 11, 2017 at 9:47 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> EBADMSG was only added to OpenBSD very recently. To make QEMU compilable
>> on older OpenBSD versions use EMSGSIZE instead when a mismatch between
>> number of received bytes and message size indicated in the header was
>> found.
>>
>> Return -EMSGSIZE and convert all other errnos in the same functions to
>> return the negative errno.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>
> Looks good to me,
> but given that the return value isn't used, perhaps you could have
> changed the function to return a bool success instead?

AIUI this is just test code, so we probably don't gain too much
from extensively bikeshedding it. (Having said that, I can't
resist asking why it's not in tests/ :-))

thanks
-- PMM
