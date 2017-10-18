Received: from eggs.gnu.org ([2001:4830:134:3::10]:33727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4p72-0001Pt-DU
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4p6x-00063P-UW
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:14:24 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:56646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4p6x-000632-OP
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:14:19 -0400
Received: by mail-pg0-x232.google.com with SMTP id m18so4367688pgd.13
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 07:14:19 -0700 (PDT)
References: <20171017153742.10026-1-richard.henderson@linaro.org>
	<20171017153742.10026-10-richard.henderson@linaro.org>
	<20171018133428.GI9719@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b381bc3-d5a9-1dc6-c48d-702b76e5968c@linaro.org>
Date: Wed, 18 Oct 2017 07:14:15 -0700
MIME-Version: 1.0
In-Reply-To: <20171018133428.GI9719@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 9/9] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On 10/18/2017 06:34 AM, Daniel P. Berrange wrote:
> Thus I think we really ought to deal with capstone in the same
> way as dtc. We could make the check a little more advanced so that
> it checks for the particular capstone feature QEMU wants. That way
> if someone does have an outdated capstone we'd still use the submodule.

There's nothing I'm aware of besides bug fixes in between e.g. the fedora26
version of capstone and the one from git.


r~
