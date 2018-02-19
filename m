Received: from eggs.gnu.org ([2001:4830:134:3::10]:56993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1enlwA-0002Vk-M8
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1enlw9-00026b-UT
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:56:58 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:34890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1enlw8-00026A-Ln
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:56:57 -0500
Received: by mail-oi0-x22a.google.com with SMTP id y4so6945128oix.2
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 05:56:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87lgfr7nt3.fsf@linaro.org>
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<CAFEAcA8kq5PekaZVm5VpgLwa+VJYVX8pC5fE8RK8QiC9qA-aYw@mail.gmail.com>
	<87lgfr7nt3.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2018 13:56:35 +0000
Message-ID: <CAFEAcA8r2-4ZrK1RX8thnY0wRxT4bOZTjBASSP97JRcO_Bjnaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/22] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 17 February 2018 at 13:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> If you persuade git to use the --minimal, --patience or --histogram
>> git diff option when generating these patches you'll find that it
>> doesn't produce unreadable patches that provoke all the checkpatch
>> warnings.
>
> I think this is patchew getting confused

Oh yes, sorry. Fam, can we update patchew's git config to use
  git config --global diff.algorithm histogram
(equivalently, algorithm =3D histogram in the .gitconfig) -- that
way the patches it runs checkpatch on are more likely to be
formatted so that they minimise spurious checkpatch output, I think.

thanks
-- PMM
