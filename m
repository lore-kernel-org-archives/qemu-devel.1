Received: from eggs.gnu.org ([2001:4830:134:3::10]:38289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXl4R-0008WR-Vm
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXl4O-0003Bg-91
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:51:51 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gXl4N-0003AA-R8
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:51:48 -0500
Received: by mail-wr1-f48.google.com with SMTP id u4so3991869wrp.3
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 02:51:47 -0800 (PST)
References: <20181212102548.27626-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <807c60e6-2a76-d7e4-6cbf-ef305b784ce7@redhat.com>
Date: Fri, 14 Dec 2018 11:51:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181212102548.27626-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2] contrib: add a basic gitdm config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, maxim.kuvyrkov@linaro.org

On 12/12/18 11:25 AM, Alex Bennée wrote:
> This is a QEMU specific version of a gitdm config for generating
> reports on the contributor base of the project. I've added enough
> group maps and domain aliases to ensure the current top ten is as
> reflective as it can be. As of this commit running:
> 
>   git log --numstat --since "Last Year" | gitdm -n -l 10
> 
> Reports:
> 
>   Top changeset contributors by employer
>   Red Hat                   3126 (44.0%)
>   Linaro                    1166 (16.4%)
>   (None)                     684 (9.6%)
>   IBM                        348 (4.9%)
>   Virtuozzo                  168 (2.4%)
>   Xilinx                     102 (1.4%)
>   Wave Computing             101 (1.4%)
>   Igalia                      93 (1.3%)
>   Cadence Design Systems      88 (1.2%)
>   SiFive                      59 (0.8%)
> 
>   Top lines changed by employer
>   Red Hat                   143166 (27.9%)
>   Cadence Design Systems    126554 (24.6%)
>   Linaro                    78845 (15.3%)
>   Wave Computing            32263 (6.3%)
>   (None)                    21789 (4.2%)
>   SiFive                    14392 (2.8%)
>   IBM                       12219 (2.4%)
>   Virtuozzo                 10445 (2.0%)
>   CodeWeavers               9179 (1.8%)
>   Xilinx                    4572 (0.9%)
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - use aliases instead of .mailmap
>   - add more companies to domainmap
>   - add more groups to cover non-corporate email
>   - add an individuals group-map for (None)
>   - limit the stats to top ten
> ---
>  contrib/gitdm/aliases               |  27 +++
>  contrib/gitdm/domain-map            |  18 ++
>  contrib/gitdm/filetypes.txt         | 362 ++++++++++++++++++++++++++++
>  contrib/gitdm/group-map-cadence     |   3 +
>  contrib/gitdm/group-map-codeweavers |   1 +
>  contrib/gitdm/group-map-ibm         |   6 +
>  contrib/gitdm/group-map-redhat      |   7 +
>  contrib/gitdm/group-map-wavecomp    |   9 +
>  gitdm.config                        |  48 ++++
>  9 files changed, 481 insertions(+)
>  create mode 100644 contrib/gitdm/aliases
>  create mode 100644 contrib/gitdm/domain-map
>  create mode 100644 contrib/gitdm/filetypes.txt
>  create mode 100644 contrib/gitdm/group-map-cadence
>  create mode 100644 contrib/gitdm/group-map-codeweavers
>  create mode 100644 contrib/gitdm/group-map-ibm
>  create mode 100644 contrib/gitdm/group-map-redhat
>  create mode 100644 contrib/gitdm/group-map-wavecomp
>  create mode 100644 gitdm.config
> 
> diff --git a/contrib/gitdm/aliases b/contrib/gitdm/aliases
> new file mode 100644
> index 0000000000..07fd3391a5
> --- /dev/null
> +++ b/contrib/gitdm/aliases
> @@ -0,0 +1,27 @@
> +#
> +# This is the email aliases file, mapping secondary addresses
> +# onto a single, canonical address. Duplicates some info from .mailmap
> +#
> +
> +# weird commits
> +balrog@c046a42c-6fe2-441c-8c8c-71466251a162 balrogg@gmail.com
> +aliguori@c046a42c-6fe2-441c-8c8c-71466251a162 anthony@codemonkey.ws
> +aurel32@c046a42c-6fe2-441c-8c8c-71466251a162 aurelien@aurel32.net
> +blueswir1@c046a42c-6fe2-441c-8c8c-71466251a162 blauwirbel@gmail.com
> +edgar_igl@c046a42c-6fe2-441c-8c8c-71466251a162 edgar.iglesias@gmail.com
> +bellard@c046a42c-6fe2-441c-8c8c-71466251a162 fabrice@bellard.org
> +j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162 l_indien@magic.fr
> +pbrook@c046a42c-6fe2-441c-8c8c-71466251a162 paul@codesourcery.com
> +ths@c046a42c-6fe2-441c-8c8c-71466251a162 ths@networkno.de
> +malc@c046a42c-6fe2-441c-8c8c-71466251a162 av1474@comtv.ru
> +
> +# There is also a:
> +#    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
> +# for the cvs2svn initialization commit e63c3dc74bf.
> +
> +# Next, translate a few commits where mailman rewrote the From: line due
> +# to strict SPF, although we prefer to avoid adding more entries like that.
> +"Ed Swierk via Qemu-devel" eswierk@skyportsystems.com
> +"Ian McKellar via Qemu-devel" ianloic@google.com
> +"Julia Suvorova via Qemu-devel" jusual@mail.ru
> +"Justin Terry (VM) via Qemu-devel" juterry@microsoft.com
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> new file mode 100644
> index 0000000000..7caf7c6332
> --- /dev/null
> +++ b/contrib/gitdm/domain-map
> @@ -0,0 +1,18 @@
> +#
> +# QEMU gitdm domain-map
> +#
> +# This maps email domains to nice easy to read company names
> +#
> +
> +amd.com         AMD
> +ibm.com         IBM
> +igalia.com      Igalia
> +ispras.ru       Institute for System Programming of RAS
> +linaro.org      Linaro
> +oracle.com      Oracle
> +redhat.com      Red Hat
> +siemens.com     Siemens
> +sifive.com      SiFive
> +suse.de         SUSE
> +virtuozzo.com   Virtuozzo
> +xilinx.com      Xilinx
> diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
> new file mode 100644
> index 0000000000..e24c396b48
> --- /dev/null
> +++ b/contrib/gitdm/filetypes.txt
> @@ -0,0 +1,362 @@
> +# -*- coding:utf-8 -*-
> +# Copyright (C)  2006 Libresoft
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option  any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU Library General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> +#
> +# Authors : Gregorio Robles <grex@gsyc.escet.urjc.es>
> +# Authors : Germán Póo-Caamaño <gpoo@gnome.org>
> +#
> +# This file contains associations parameters regarding filetypes
> +# (documentation, develompent, multimedia, images...)
> +#
> +# format:
> +# filetype <type> <regex> [<comment>]
> +#
> +# Order:
> +#   The list should keep an order, so filetypes can be counted properly.
> +#   ie. we want ltmain.sh -> 'build' instead of 'code'.
> +#
> +#   If there is an filetype which is not in order but has values, it will
> +#   be added at the end.
> +#
> +order image,translation,ui,multimedia,package,build,code,documentation,devel-doc
> +#
> +#
> +# Code files (headers and the like included
> +# (most common languages first
> +#
> +filetype code \.c$	# C
> +filetype code \.pc$	# C
> +filetype code \.ec$	# C
> +filetype code \.ecp$	# C
> +filetype code \.C$	# C++
> +filetype code \.cpp$	# C++
> +filetype code \.c\+\+$	# C++
> +filetype code \.cxx$	# C++
> +filetype code \.cc$	# C++
> +filetype code \.pcc$	# C++
> +filetype code \.cpy$	# C++
> +filetype code \.h$	# C or C++ header
> +filetype code \.hh$	# C++ header
> +filetype code \.hpp$	# C++ header
> +filetype code \.hxx$	# C++ header
> +filetype code \.sh$	# Shell
> +filetype code \.pl$	# Perl
> +filetype code \.pm$	# Perl
> +filetype code \.pod$	# Perl
> +filetype code \.perl$	# Perl
> +filetype code \.cgi$	# CGI
> +filetype code \.php$	# PHP
> +filetype code \.php3$	# PHP
> +filetype code \.php4$	# PHP
> +filetype code \.inc$	# PHP
> +filetype code \.py$	# Python
> +filetype code \.java$	# Java
> +filetype code \.class$	# Java Class (or at least a class in some OOPL
> +filetype code \.ada$	# ADA
> +filetype code \.ads$	# ADA
> +filetype code \.adb$	# ADA
> +filetype code \.pad$	# ADA
> +filetype code \.s$	# Assembly
> +filetype code \.S$	# Assembly
> +filetype code \.asm$	# Assembly
> +filetype code \.awk$	# awk
> +filetype code \.cs$	# C#
> +filetype code \.csh$	# CShell (including tcsh
> +filetype code \.cob$	# COBOL
> +filetype code \.cbl$	# COBOL
> +filetype code \.COB$	# COBOL
> +filetype code \.CBL$	# COBOL
> +filetype code \.exp$	# Expect
> +filetype code \.l$	# (F lex
> +filetype code \.ll$	# (F lex
> +filetype code \.lex$	# (F lex
> +filetype code \.f$	# Fortran
> +filetype code \.f77$	# Fortran
> +filetype code \.F$	# Fortran
> +filetype code \.hs$	# Haskell
> +filetype code \.lhs$	# Not preprocessed Haskell
> +filetype code \.el$	# LISP (including Scheme
> +filetype code \.scm$	# LISP (including Scheme
> +filetype code \.lsp$	# LISP (including Scheme
> +filetype code \.jl$	# LISP (including Scheme
> +filetype code \.ml$	# ML
> +filetype code \.ml3$	# ML
> +filetype code \.m3$	# Modula3
> +filetype code \.i3$	# Modula3
> +filetype code \.m$	# Objective-C
> +filetype code \.p$	# Pascal
> +filetype code \.pas$	# Pascal
> +filetype code \.rb$	# Ruby
> +filetype code \.sed$	# sed
> +filetype code \.tcl$	# TCL
> +filetype code \.tk$	# TCL
> +filetype code \.itk$	# TCL
> +filetype code \.y$	# Yacc
> +filetype code \.yy$	# Yacc
> +filetype code \.idl$	# CORBA IDL
> +filetype code \.gnorba$	# GNOME CORBA IDL
> +filetype code \.oafinfo$	# GNOME OAF
> +filetype code \.mcopclass$	# MCOP IDL compiler generated class
> +filetype code \.autoforms$	# Autoform
> +filetype code \.atf$	# Autoform
> +filetype code \.gnuplot$
> +filetype code \.xs$	# Shared library? Seen a lot of them in gnome-perl
> +filetype code \.js$	# JavaScript (and who knows, maybe more
> +filetype code \.patch$
> +filetype code \.diff$	# Sometimes patches appear this way
> +filetype code \.ids$	# Not really sure what this means
> +filetype code \.upd$	# ¿¿¿??? (from Kcontrol
> +filetype code $.ad$ 	# ¿¿¿??? (from Kdisplay and mc
> +filetype code $.i$	# Appears in the kbindings for Qt
> +filetype code $.pri$	# from Qt
> +filetype code \.schema$	# Not really sure what this means
> +filetype code \.fd$	# Something to do with latex
> +filetype code \.cls$	# Something to do with latex
> +filetype code \.pro$	# Postscript generation
> +filetype code \.ppd$	# PDF generation
> +filetype code \.dlg$	# Not really sure what this means
> +filetype code \.plugin$	# Plug-in file
> +filetype code \.dsp	# Microsoft Developer Studio Project File
> +filetype code \.vim$	# vim syntax file
> +filetype code \.trm$	# gnuplot term file
> +filetype code \.font$	# Font mapping
> +filetype code \.ccg$	# C++ files - Found in gtkmm*
> +filetype code \.hg$	# C++ headers - Found in gtkmm*
> +filetype code \.dtd	# XML Document Type Definition
> +filetype code \.bat	# DOS batch files
> +filetype code \.vala	# Vala
> +filetype code \.py\.in$
> +filetype code \.rhtml$	# eRuby
> +filetype code \.sql$	# SQL script
> +#
> +#
> +# Development documentation files (for hacking generally
> +#
> +filetype devel-doc ^readme.*$
> +filetype devel-doc ^changelog.*
> +filetype devel-doc ^todo.*$
> +filetype devel-doc ^credits.*$
> +filetype devel-doc ^authors.*$
> +filetype devel-doc ^changes.*$
> +filetype devel-doc ^news.*$
> +filetype devel-doc ^install.*$
> +filetype devel-doc ^hacking.*$
> +filetype devel-doc ^copyright.*$
> +filetype devel-doc ^licen(s|c)e.*$
> +filetype devel-doc ^copying.*$
> +filetype devel-doc manifest$
> +filetype devel-doc faq$
> +filetype devel-doc building$
> +filetype devel-doc howto$
> +filetype devel-doc design$
> +filetype devel-doc \.files$
> +filetype devel-doc files$
> +filetype devel-doc subdirs$
> +filetype devel-doc maintainers$
> +filetype devel-doc developers$
> +filetype devel-doc contributors$
> +filetype devel-doc thanks$
> +filetype devel-doc releasing$
> +filetype devel-doc test$
> +filetype devel-doc testing$
> +filetype devel-doc build$
> +filetype devel-doc comments?$
> +filetype devel-doc bugs$
> +filetype devel-doc buglist$
> +filetype devel-doc problems$
> +filetype devel-doc debug$
> +filetype devel-doc hacks$
> +filetype devel-doc hacking$
> +filetype devel-doc versions?$
> +filetype devel-doc mappings$
> +filetype devel-doc tips$
> +filetype devel-doc ideas?$
> +filetype devel-doc spec$
> +filetype devel-doc compiling$
> +filetype devel-doc notes$
> +filetype devel-doc missing$
> +filetype devel-doc done$
> +filetype devel-doc \.omf$	# XML-based format used in GNOME
> +filetype devel-doc \.lsm$
> +filetype devel-doc ^doxyfile$
> +filetype devel-doc \.kdevprj$
> +filetype devel-doc \.directory$
> +filetype devel-doc \.dox$
> +filetype devel-doc \.doap$
> +#
> +#
> +# Building, compiling, configuration and CVS admin files
> +#
> +filetype build \.in.*$
> +filetype build configure.*$
> +filetype build makefile.*$
> +filetype build config\.sub$
> +filetype build config\.guess$
> +filetype build config\.status$
> +filetype build ltmain\.sh$
> +filetype build autogen\.sh$
> +filetype build config$
> +filetype build conf$
> +filetype build cvsignore$
> +filetype build \.cfg$
> +filetype build \.m4$
> +filetype build \.mk$
> +filetype build \.mak$
> +filetype build \.make$
> +filetype build \.mbx$
> +filetype build \.protocol$
> +filetype build \.version$
> +filetype build mkinstalldirs$
> +filetype build install-sh$
> +filetype build rules$
> +filetype build \.kdelnk$
> +filetype build \.menu$
> +filetype build linguas$	# Build translations
> +filetype build potfiles.*$	# Build translations
> +filetype build \.shlibs$	# Shared libraries
> +# filetype build %debian%
> +# filetype build %specs/%
> +filetype build \.spec$	# It seems theyre necessary for RPM build
> +filetype build \.def$	# build bootstrap for DLLs on win32
> +#
> +#
> +# Documentation files
> +#
> +# filetype documentation doc/%
> +# filetype documentation %HOWTO%
> +filetype documentation \.html$
> +filetype documentation \.txt$
> +filetype documentation \.ps(\.gz|\.bz2)?$
> +filetype documentation \.dvi(\.gz|\.bz2)?$
> +filetype documentation \.lyx$
> +filetype documentation \.tex$
> +filetype documentation \.texi$
> +filetype documentation \.pdf(\.gz|\.bz2)?$
> +filetype documentation \.djvu$
> +filetype documentation \.epub$
> +filetype documentation \.sgml$
> +filetype documentation \.docbook$
> +filetype documentation \.wml$
> +filetype documentation \.xhtml$
> +filetype documentation \.phtml$
> +filetype documentation \.shtml$
> +filetype documentation \.htm$
> +filetype documentation \.rdf$
> +filetype documentation \.phtm$
> +filetype documentation \.tmpl$
> +filetype documentation \.ref$	# References
> +filetype documentation \.css$
> +# filetype documentation %tutorial%
> +filetype documentation \.templates$
> +filetype documentation \.dsl$
> +filetype documentation \.ent$
> +filetype documentation \.xml$
> +filetype documentation \.xmi$
> +filetype documentation \.xsl$
> +filetype documentation \.entities$
> +filetype documentation \.[1-7]$	# Man pages
> +filetype documentation \.man$
> +filetype documentation \.manpages$
> +filetype documentation \.doc$
> +filetype documentation \.rtf$
> +filetype documentation \.wpd$
> +filetype documentation \.qt3$
> +filetype documentation man\d?/.*\.\d$
> +filetype documentation \.docs$
> +filetype documentation \.sdw$	# OpenOffice.org Writer document
> +filetype documentation \.odt$	# OpenOffice.org document
> +filetype documentation \.en$	# Files in English language
> +filetype documentation \.de$	# Files in German
> +filetype documentation \.es$	# Files in Spanish
> +filetype documentation \.fr$	# Files in French
> +filetype documentation \.it$	# Files in Italian
> +filetype documentation \.cz$	# Files in Czech
> +filetype documentation \.page$	# Mallard
> +filetype documentation \.page.stub$	# Mallard stub
> +#
> +#
> +# Images
> +#
> +filetype image \.png$
> +filetype image \.jpg$
> +filetype image \.jpeg$
> +filetype image \.bmp$
> +filetype image \.gif$
> +filetype image \.xbm$
> +filetype image \.eps$
> +filetype image \.mng$
> +filetype image \.pnm$
> +filetype image \.pbm$
> +filetype image \.ppm$
> +filetype image \.pgm$
> +filetype image \.gbr$
> +filetype image \.svg$
> +filetype image \.fig$
> +filetype image \.tif$
> +filetype image \.swf$
> +filetype image \.svgz$
> +filetype image \.shape$	# XML files used for shapes for instance in Kivio
> +filetype image \.sml$	# XML files used for shapes for instance in Kivio
> +filetype image \.bdf$	#  vfontcap  - Vector Font Capability Database (VFlib Version 2
> +filetype image \.ico$
> +filetype image \.dia$	# We consider .dia as images, I dont want them in unknown
> +#
> +#
> +# Translation files
> +#
> +filetype translation \.po$
> +filetype translation \.pot$
> +filetype translation \.charset$
> +filetype translation \.mo$
> +#
> +#
> +# User interface files
> +#
> +filetype ui \.desktop$
> +filetype ui \.ui$
> +filetype ui \.xpm$
> +filetype ui \.xcf$
> +filetype ui \.3ds$
> +filetype ui \.theme$
> +filetype ui \.kimap$
> +filetype ui \.glade$
> +filetype ui \.gtkbuilder$
> +filetype ui rc$
> +#
> +#
> +# Sound files
> +#
> +filetype multimedia \.mp3$
> +filetype multimedia \.ogg$
> +filetype multimedia \.wav$
> +filetype multimedia \.au$
> +filetype multimedia \.mid$
> +filetype multimedia \.vorbis$
> +filetype multimedia \.midi$
> +filetype multimedia \.arts$
> +#
> +#
> +# Packages (yes, there are people who upload packages to the repo)
> +#
> +filetype package \.tar$
> +filetype package \.tar.gz$
> +filetype package \.tar.bz2$
> +filetype package \.tar.xz$
> +filetype package \.tgz$
> +filetype package \.deb$
> +filetype package \.rpm$
> +filetype package \.srpm$
> +filetype package \.ebuild$
> diff --git a/contrib/gitdm/group-map-cadence b/contrib/gitdm/group-map-cadence
> new file mode 100644
> index 0000000000..ab97dd2fc3
> --- /dev/null
> +++ b/contrib/gitdm/group-map-cadence
> @@ -0,0 +1,3 @@
> +# Cadence Design Systems
> +
> +jcmvbkbc@gmail.com
> diff --git a/contrib/gitdm/group-map-codeweavers b/contrib/gitdm/group-map-codeweavers
> new file mode 100644
> index 0000000000..c4803489e2
> --- /dev/null
> +++ b/contrib/gitdm/group-map-codeweavers
> @@ -0,0 +1 @@
> +sergio.g.delreal@gmail.com
> diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
> new file mode 100644
> index 0000000000..b66db5f4a8
> --- /dev/null
> +++ b/contrib/gitdm/group-map-ibm
> @@ -0,0 +1,6 @@
> +#
> +# Some IBM contributors submit via another domain
> +#
> +
> +clg@kaod.org
> +groug@kaod.org
> diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-redhat
> new file mode 100644
> index 0000000000..252742d131
> --- /dev/null
> +++ b/contrib/gitdm/group-map-redhat
> @@ -0,0 +1,7 @@
> +#
> +# RedHat contributors using non-corporate email
> +#
> +
> +david@gibson.dropbear.id.au
> +laurent@vivier.eu

Cc'ing Laurent, I understood he manages the commit signed under his
personal email during his hobbyist time.

> +pjp@fedoraproject.org
> diff --git a/contrib/gitdm/group-map-wavecomp b/contrib/gitdm/group-map-wavecomp
> new file mode 100644
> index 0000000000..772856bca8
> --- /dev/null
> +++ b/contrib/gitdm/group-map-wavecomp
> @@ -0,0 +1,9 @@
> +#
> +# Wave Computing acquired MIPS in June 2018 from imgtec
> +#
> +
> +amarkovic@wavecomp.com
> +smarkovic@wavecomp.com
> +paul.burton@imgtec.com
> +yongbok.kim@imgtec.com
> +yongbok.kim@mips.com
> diff --git a/gitdm.config b/gitdm.config
> new file mode 100644
> index 0000000000..69e5223d90
> --- /dev/null
> +++ b/gitdm.config
> @@ -0,0 +1,48 @@
> +#
> +# This is the gitdm configuration file for QEMU.
> +#
> +# It is to be used with LWN's git dataminer tool for generating
> +# reports about development activity in the QEMU repo. The LWN gitdm
> +# tool can be found at:
> +#
> +#   git://git.lwn.net/gitdm.git
> +#
> +# A run to generate a report for the last year of activity would be
> +#
> +#     $ git-log --numstat -M v2.12.0..v3.0.0 | gitdm -n -l 16
> +#
> +
> +# EmailAliases lets us cope with developers who use more
> +# than one address or have changed addresses. This duplicates some of
> +# the information in the existing .mailmap but in a slightly different
> +# form.
> +#
> +EmailAliases contrib/gitdm/aliases
> +
> +#
> +# EmailMap does the main work of mapping addresses onto
> +# employers.
> +#
> +EmailMap contrib/gitdm/domain-map
> +
> +#
> +# Use GroupMap to map a file full of addresses to the
> +# same employer. This is used for people that don't post from easily
> +# identifiable corportate emails.
> +#
> +
> +GroupMap contrib/gitdm/group-map-redhat Red Hat
> +GroupMap contrib/gitdm/group-map-wavecomp Wave Computing
> +GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
> +GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
> +GroupMap contrib/gitdm/group-map-ibm IBM
> +
> +# Also group together our prolific individual contributors
> +GroupMap contrib/gitdm/group-map-individuals (None)
> +
> +#
> +#
> +# Use FileTypeMap to map a file types to file names using regular
> +# regular expressions.
> +#
> +FileTypeMap contrib/gitdm/filetypes.txt
> 
