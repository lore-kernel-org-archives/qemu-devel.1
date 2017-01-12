Received: from eggs.gnu.org ([2001:4830:134:3::10]:44631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cRgNX-00006D-Ap
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cRgNS-00079r-LE
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:29:23 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:32847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cRgNS-00077N-Ee
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:29:18 -0500
Date: Thu, 12 Jan 2017 14:28:36 +0000
From: Julian Brown <julian@codesourcery.com>
Message-ID: <20170112142836.53bbd87b@squid.athome>
In-Reply-To: <20170111123552.1873cb3b@squid.athome>
References: <cover.1481121503.git.julian@codesourcery.com>
	<b7f0904f00d135f9b2760b8881dbc9ead23cedbf.1481121503.git.julian@codesourcery.com>
	<CAFEAcA-EQ-e39uv1rnTUb5SwDZzPrHUfhydY5hzc8CrP4NhX_w@mail.gmail.com>
	<20170111123552.1873cb3b@squid.athome>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] Add cfgend parameter for ARM CPU
 selection.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 11 Jan 2017 12:35:52 +0000
Julian Brown <julian@codesourcery.com> wrote:

> I'm a little confused, I think -- these changes seemed to be necessary
> to allow the parsing of the command-line syntax you suggested earlier
> (-mcpu=foo,cfgend=bar):
> [...]
> Can the existing properties be set like that via the command line?

Aha! The answer was yes, but only currently for the "virt" board
(which we haven't been using for aarch32, and only supports a few recent
CPU types at present). I'm less confused now! (The string-splitting code
in arm_cpu_class_by_name is still dubious though, IMO.)

Cheers,

Julian
