Received: from eggs.gnu.org ([2001:4830:134:3::10]:53657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPyry-0006Xq-I3
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPyrv-0007M6-DX
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPyrv-0007Lo-6f
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:21:59 -0400
References: <cover.1498596157.git.alistair.francis@xilinx.com>
	<4e1eded5cda7b182a8a4cb133b40b2915817b7d1.1498596157.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <df67b0cd-0b49-c0c1-fa7b-3928204e7c0b@redhat.com>
Date: Wed, 28 Jun 2017 00:21:55 +0200
MIME-Version: 1.0
In-Reply-To: <4e1eded5cda7b182a8a4cb133b40b2915817b7d1.1498596157.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 2/3] util/qemu-error: Add a
 warning_report() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, armbru@redhat.com
Cc: alistair23@gmail.com

On 27.06.2017 22:45, Alistair Francis wrote:
> Add a functino which can be used similarly to error_report() execpt to
> inform the users about warnings instead of errors.

s/functino/function/
s/execpt/except/

And could we maybe call the function "warn_report" or something else
instead? I often already have trouble with error_report() to fit the
string into one line of the scarce 80 columns space ... so the shorter
the name of the function, the more characters can be squeezed into the
string in one line later ;-)

 Thomas
