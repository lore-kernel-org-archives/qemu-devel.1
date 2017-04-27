Received: from eggs.gnu.org ([2001:4830:134:3::10]:38662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3aAc-0002aa-R1
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3aAc-0003gc-0c
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:32:42 -0400
Date: Wed, 26 Apr 2017 23:32:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170427033239.GA19380@flamenco>
References: <1493263764-18657-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493263764-18657-1-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v4 00/11] TCG optimizations for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

Just to avoid confusion,

On Wed, Apr 26, 2017 at 23:29:13 -0400, Emilio G. Cota wrote:
> I have *not* re-run all experiments, because it takes several hours and
> performance hasn't changed much from v3, as can be seen in these two charts:
> * spec06int user-mode, test input, v2.9.0 baseline: http://imgur.com/ME2eMq1

Here v4 doesn't have the htable lookup. (v4+htable has it)

> * spec06int softmmu, test input, v3 baseline: http://imgur.com/Clolu9Z

Here v4 does have it.

		E.
