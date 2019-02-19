Received: from eggs.gnu.org ([209.51.188.92]:45778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw9bs-00037N-Q1
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw9bs-00037H-2W
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:55:12 -0500
References: <20190219013106.17538-1-richardw.yang@linux.intel.com>
	<20190219013106.17538-2-richardw.yang@linux.intel.com>
	<e59b0920-4698-a0d1-7990-77d9e2202f9b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83037dad-5d57-2ebd-0038-27dd38975d3f@redhat.com>
Date: Tue, 19 Feb 2019 11:55:04 -0600
MIME-Version: 1.0
In-Reply-To: <e59b0920-4698-a0d1-7990-77d9e2202f9b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] CODING_STYLE: specify the indent rule
 for multiline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: imammedo@redhat.com, mjt@tls.msk.ru

On 2/19/19 11:34 AM, Philippe Mathieu-Daud=C3=A9 wrote:

>=20
> What is still unclear is what to do when a function name is over 60
> characters (you follow a library/API and can not shorten it), for examp=
le:
>=20
> static void ccid_card_vscard_handle_message(PassthruState *card,
>     const VSCMsgHeader *scr_msg_header);
>=20
> What is the project guideline in this case?

I don't know that we have an official guideline, but I've seen enough
code doing that. I've also seen this style:

static void long_func_name(
    parameter one, parameter two)
{
    if (condition) {
        call_some_really_long_name(
            arg1,
            arg2);
    }

where even the first argument is put at an indentation of 4 from the
primary line.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
