Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1ECC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A84E20693
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A84E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53973 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEfcF-0005h1-AR
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 15:44:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfb3-0004lm-16
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfb2-00081H-3e
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:42:52 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hEfaz-0007wb-Fo; Thu, 11 Apr 2019 15:42:49 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MjPYI-1gToRY0gzy-00ktOB; Thu, 11 Apr 2019 21:42:30 +0200
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
References: <20190304071631.27567-1-richardw.yang@linux.intel.com>
	<20190304071631.27567-2-richardw.yang@linux.intel.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4cd402a1-4da3-dc2e-82ad-64249c5fddc0@vivier.eu>
Date: Thu, 11 Apr 2019 21:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190304071631.27567-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DGvzF2MUh6/4IttUnWwEwhdKCoxVcHIfGD1tcJ6eGL2HHMnjpYw
	QfqfGLUqXfww6rbkG5juDXjIgQF9EDe+d4P7S3vpTjY4KM9PNsrzetM+TsLNq/5oxknES9b
	R3nV+SX5e5f4tJC54GypdOZLN3CcdSg3mzdm7OdGZTHVG5fpsTm1rMxjg5y7+AEmuXVZuvx
	N5ksJ2rRYAYuRCnHas3vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G9LdzMCpeZs=:p+39jBTTEAoYyWJrKY4Hti
	NrY3gUFee0EFPz/4xUL+WToE12mWsy1C0uaK8t+Gra7ut4pAuPF7LFq9NokIbVpJvKR2xBAwB
	8jbOpQi2kk1R5hEavibFAu0ICsNlTNS8EZj5HFXpY5KubBwcdZmTkof5AEPVRV7pCapfOrgTQ
	5JQqHeTplT1xGvr0sYIzBDhYb4PF1xDFme9vjEeuSGSXSn1ptYtIl7G/0tP6zobqSBWeym5nS
	xu/tajB3Wcthqf86QNWAZXNJijidiqKMsKJOl/QyAWxpAqC2WaObnOCj1O0DaAc60cjn97xv0
	22kP1l2SJvNFzNAKVsLICfuEGAIEmswPFDxqD36wk1ulIsezKgkO7AJb8FwsXzSxAI6NfzLr0
	3lfj+b5Xfqi9MuXqu53J7RrIfYoKAh7r6k9CjIZ0w25/YIXbJ3uZglFICbNAsgCGIvQkqa3a7
	hK4dm7bVqeRB6zQcceChYFGJ9bqAUMd5n4ItF/9FAnrW/ZflBa+xsddsRoBIR8EcsarsQMiS5
	tFnsvBqXmmfhM6LcjKrazUngXTACcdPlItu/iHHmUn3H/d8q2ICeFq3a9XHz0Dg4sY7HQctPS
	57paCaLe75Daz9FSFQQIBqXLhW8IGDGOHbhMFf39RHA3/bCagaCzkT+tOwJ2Bj70/5Rj5CaIS
	GEYyacg1oNSCX9tKZAp85GZ1EDtrzV6fcAuxadchIP74R6KAxqeWSRkDGyzruleRuKehLS0dE
	+L6FH9aqhLOpebYEW9tqr1Zi3DkqqAYv/3TaNYjGP42UxxWORzvuIwL+SpE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v6 1/2] CODING_STYLE:
 specify the indent rule for multiline code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, mjt@tls.msk.ru, imammedo@redhat.com,
	philmd@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411194226.kNokBLzZZU7PchE2lkACX9JXa99dJPlDdQ0lREgHOTE@z>

On 04/03/2019 08:16, Wei Yang wrote:
> We didn't specify the indent rule for multiline code here, which may
> mislead users. And in current code, the code use various styles.
> 
> Add this rule in CODING_STYLE to make sure this is clear to every one.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> 
> ---
> v6:
>    * add ) for last example of function
> v5:
>    * different rules -> various styles
>    * describe function variants separately
>    * take struct out
> v4:
>    * widths -> width
>    * add an exception example for function
> v3:
>    * misleading -> mislead
>    * add comma after arg2 in example
> v2:
>    * rephrase changelog suggested by Eric Blake
>      - remove one redundant line
>      - fix some awkward grammar
>      - add { ; at the end of example
> ---
>  CODING_STYLE | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/CODING_STYLE b/CODING_STYLE
> index ec075dedc4..90321e9c28 100644
> --- a/CODING_STYLE
> +++ b/CODING_STYLE
> @@ -29,6 +29,45 @@ Spaces of course are superior to tabs because:
>  
>  Do not leave whitespace dangling off the ends of lines.
>  
> +1.1 Multiline Indent
> +
> +There are several places where indent is necessary:
> +
> + - if/else
> + - while/for
> + - function definition & call
> +
> +When breaking up a long line to fit within line width, we need a proper indent
> +for the following lines.
> +
> +In case of if/else, while/for, align the secondary lines just after the
> +opening parenthesis of the first.
> +
> +For example:
> +
> +    if (a == 1 &&
> +        b == 2) {
> +
> +    while (a == 1 &&
> +           b == 2) {
> +
> +In case of function, there are several variants:
> +
> +    * 4 spaces indent from the beginning
> +    * align the secondary lines just after the opening parenthesis of the
> +      first
> +
> +For example:
> +
> +    do_something(x, y,
> +        z);
> +
> +    do_something(x, y,
> +                 z);
> +
> +    do_something(x, do_another(y,
> +                               z));
> +
>  2. Line width
>  
>  Lines should be 80 characters; try not to make them longer.
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

