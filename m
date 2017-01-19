Received: from eggs.gnu.org ([2001:4830:134:3::10]:51826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUH2q-0007hb-EW
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUH2n-0003DJ-5T
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:02:44 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:39282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cUH2m-0003B6-Uw
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:02:41 -0500
Date: Thu, 19 Jan 2017 18:02:23 +0000
From: Julian Brown <julian@codesourcery.com>
Message-ID: <20170119180223.55d75d6d@squid.athome>
In-Reply-To: <CAFEAcA-VmK+oMdV7GONa=H2v6Oz1uO=gaM3UgRf0SvK1QHO+3w@mail.gmail.com>
References: <cover.1481121503.git.julian@codesourcery.com>
	<b7f0904f00d135f9b2760b8881dbc9ead23cedbf.1481121503.git.julian@codesourcery.com>
	<CAFEAcA-EQ-e39uv1rnTUb5SwDZzPrHUfhydY5hzc8CrP4NhX_w@mail.gmail.com>
	<20170111123552.1873cb3b@squid.athome>
	<20170112142836.53bbd87b@squid.athome>
	<CAFEAcA8eYeLNrTK-hupM9jA7CPjD8OgEU85As94fWXQETxRgXA@mail.gmail.com>
	<20170118165256.GC6657@thinpad.lan.raisama.net>
	<CAFEAcA-VmK+oMdV7GONa=H2v6Oz1uO=gaM3UgRf0SvK1QHO+3w@mail.gmail.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 19 Jan 2017 15:12:49 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> I'm actually looking at a patch at the moment that attempts
> to fix this by adding a cpu_generic_init_unrealized(),
> which does everything that cpu_generic_init() does except
> the final "set the realized prop to true" step, so that you
> can call it, set CPU properties and then realize the CPU
> yourself. Does that sound like a good idea, or a bad idea?
> [https://github.com/mdavidsaver/qemu/commit/82823fb6f97859dc5f2945bd3b2733df2c81b2d8]
> 
> I'm not sure which board Julian is using, but I guess it's one
> of the ones that doesn't call cpu_generic_init().

We're using integratorcp -- I'm working on a v3 of my patch series that
adds the CPU-attribute parsing to (just) that. It'll be ready soonish.

Thanks,

Julian
