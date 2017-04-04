Received: from eggs.gnu.org ([2001:4830:134:3::10]:33129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cvRho-0000XI-N8
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cvRhn-0007p4-TH
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:53:20 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cvRhn-0007o0-Pl
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:53:19 -0400
Received: by mail-qt0-x244.google.com with SMTP id n37so24039937qtb.3
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 09:53:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-5-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ac3d8bc5-d4e1-6313-f1a2-7cc4867cd153@twiddle.net>
Date: Tue, 4 Apr 2017 09:53:15 -0700
MIME-Version: 1.0
In-Reply-To: <20170403124524.10824-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 4/9] target/i386/misc_helper: wrap
 BQL around another IRQ generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, dovgaluk@ispras.ru, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Eduardo Habkost <ehabkost@redhat.com>

On 04/03/2017 05:45 AM, Alex Bennée wrote:
> Anything that calls into HW emulation must be protected by the BQL.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/i386/misc_helper.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
