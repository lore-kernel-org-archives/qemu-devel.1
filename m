Received: from eggs.gnu.org ([2001:4830:134:3::10]:43835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctuzC-0008I7-TT
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctuz9-0000x9-Tu
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:44:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ctuz9-0000wE-Nr
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:44:55 -0400
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<1490856931-21732-3-git-send-email-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0985e06f-87c0-19bf-2c84-e63f990158b9@redhat.com>
Date: Fri, 31 Mar 2017 13:44:51 +0200
MIME-Version: 1.0
In-Reply-To: <1490856931-21732-3-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RfC PATCH 2/4] memory: add support getting and
 using a dirty bitmap copy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>



On 30/03/2017 08:55, Gerd Hoffmann wrote:
>  
> +struct DirtyCopy {
> +    ram_addr_t start;
> +    ram_addr_t end;
> +    unsigned long dirty[];
> +};
> +
>  #endif

Maybe DirtyBitmapSnapshot (and s/copy/snapshot/ in the rest of the API too)?

Paolo
