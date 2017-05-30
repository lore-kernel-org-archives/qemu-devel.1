Received: from eggs.gnu.org ([2001:4830:134:3::10]:54976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dFqeD-0003XW-7U
	for qemu-devel@nongnu.org; Tue, 30 May 2017 19:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dFqeC-0000Qr-AH
	for qemu-devel@nongnu.org; Tue, 30 May 2017 19:33:57 -0400
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:36065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dFqeC-0000Qd-4J
	for qemu-devel@nongnu.org; Tue, 30 May 2017 19:33:56 -0400
Received: by mail-yb0-x244.google.com with SMTP id r66so2748027yba.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 16:33:54 -0700 (PDT)
MIME-Version: 1.0
Sender: bobby.prani@gmail.com
In-Reply-To: <20170517145259.28979-7-alex.bennee@linaro.org>
References: <20170517145259.28979-1-alex.bennee@linaro.org>
	<20170517145259.28979-7-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani+qemu@gmail.com>
Date: Tue, 30 May 2017 19:33:23 -0400
Message-ID: <CAJhHMCB0j9=6XBMa0GVaOt+Acf4m5Ow2DhvvvcekKJXhfM+qSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/6] new
 script/analyse-tlb-flushes-simpletrace.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Emilio G. Cota" <cota@braap.org>, qemu-devel <qemu-devel@nongnu.org>

Hi Alex,

Please find some comments and questions below:

On Wed, May 17, 2017 at 10:52 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> This is a simple helper script to extract TLB flush stats from the a
> simpletrace file and plot the results.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - re-factored for new trace events
>   - added time and latency graphs
> ---
>  scripts/analyse-tlb-flushes-simpletrace.py | 144 +++++++++++++++++++++++=
++++++
>  1 file changed, 144 insertions(+)
>  create mode 100755 scripts/analyse-tlb-flushes-simpletrace.py
>
> diff --git a/scripts/analyse-tlb-flushes-simpletrace.py b/scripts/analyse=
-tlb-flushes-simpletrace.py
> new file mode 100755
> index 0000000000..03fab8c86b
> --- /dev/null
> +++ b/scripts/analyse-tlb-flushes-simpletrace.py

<snip>

> +
> +def get_args():
> +    "Grab options"
> +    parser =3D argparse.ArgumentParser()
> +    parser.add_argument("--output", "-o", type=3Dstr, help=3D"Render plo=
t to file")
> +    parser.add_argument("--vcpus", type=3Dint, help=3D"Number of vCPUS")

It is not really clear what this argument is for. I guess you are
saying how many cpus the guest from which trace file was generated
had? What happens if we pass in less number of vcpus than used for
generation?

> +    parser.add_argument("--graph", choices=3D['time', 'latency'], defaul=
t=3D'time')

What does latency here indicate? I tried this argument on a sample
trace file I generated, and it had three empty boxes.

> +    parser.add_argument("events", type=3Dstr, help=3D'trace file read fr=
om')
> +    parser.add_argument("tracefile", type=3Dstr, help=3D'trace file read=
 from')

The help text for 'events' file here should be something like 'the
trace events file'.

Thanks,
--
Pranith
