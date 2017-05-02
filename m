Received: from eggs.gnu.org ([2001:4830:134:3::10]:43156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5bJA-0003oj-NZ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 13:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5bJ9-0001Ul-CO
	for qemu-devel@nongnu.org; Tue, 02 May 2017 13:09:52 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5bJ9-0001SU-2Q
	for qemu-devel@nongnu.org; Tue, 02 May 2017 13:09:51 -0400
Received: by mail-wr0-x22a.google.com with SMTP id l9so86804901wre.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 10:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
	<38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
In-Reply-To: <38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 02 May 2017 17:09:36 +0000
Message-ID: <CAJ+F1CKcZvWE4OQOMKuDqNvKGEQK3DdihM6Eyx-piqtQtSbXGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, berrange@redhat.com

Hi

On Tue, May 2, 2017 at 8:59 PM Stefan Berger <stefanb@linux.vnet.ibm.com>
wrote:

> On 05/02/2017 12:05 PM, Marc-Andr=C3=A9 Lureau wrote:
>
> Hi
>
> On Tue, May 2, 2017 at 3:53 PM Amarnath Valluri <
> amarnath.valluri@intel.com> wrote:
>
>> This change introduces a new TPM backend driver that can communicate wit=
h
>> swtpm(software TPM emulator) using unix domain socket interface.
>>
>> Swtpm uses two unix sockets, one for plain TPM commands and responses,
>> and one
>> for out-of-band control messages.
>>
>>
> Let's not forget to mention the external protocol this backend rely on:
> https://github.com/stefanberger/swtpm/wiki/Control-Channel-Specification
>
> The protocol documentation is quite limited.
>
> (I still question the need to rely on a public protocol, and a seperate
> helper process project. If we had a qemu-swtpm, we could more easily evol=
ve
> the protocol in the future)
>
>
> And who is going to implement that qemu-swtpm? Obviously this discussion
> doesn't contribute to progress if nobody is doing that in the end.
>

The same persons who try to push for that emulated TPM code. The easiest
approach would be to copy/adapt the swtpm code in qemu, if the licence is
compatible. I can help with that if there is a consensus it's a better
approach.
--=20
Marc-Andr=C3=A9 Lureau
